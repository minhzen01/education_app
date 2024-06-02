import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/error_constant.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/data/datasources/auth_constants.dart';
import 'package:education_app/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/entities/update_user_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(
    this._authClient,
    this._cloudStoreClient,
    this._dbClient,
  );

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? ErrorConst.errorOccurredMessage,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: ErrorConst.errorCode505,
        message: e.toString(),
      );
    }
  }

  @override
  Future<UserEntityModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerException(
          statusCode: ErrorConst.errorCodeUnknown,
          message: ErrorConst.errorTryAgainMessage,
        );
      }
      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return UserEntityModel.fromMap(userData.data()!);
      }

      await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return UserEntityModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? ErrorConst.errorOccurredMessage,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: ErrorConst.errorCode505,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(AuthConst.kDefaultAvatar);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? ErrorConst.errorOccurredMessage,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: ErrorConst.errorCode505,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(userData as String);
          await _updateUserData({AuthConst.email: userData});

        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({AuthConst.fullName: userData});
        case UpdateUserAction.profilePic:
          final ref = _dbClient.ref().child('${AuthConst.profilePicsChild}${_authClient.currentUser?.uid}');

          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({AuthConst.profilePic: url});
        case UpdateUserAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              statusCode: ErrorConst.errorCodeInsufficientPermission,
              message: ErrorConst.errorUserNotExistMessage,
            );
          }

          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData[AuthConst.oldPassword] as String,
            ),
          );
          await _authClient.currentUser?.updatePassword(
            newData[AuthConst.newPassword] as String,
          );
        case UpdateUserAction.bio:
          await _updateUserData({AuthConst.bio: userData as String});
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? ErrorConst.errorOccurredMessage,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        statusCode: ErrorConst.errorCode505,
        message: e.toString(),
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection(AuthConst.users).doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection(AuthConst.users).doc(user.uid).set(
          UserEntityModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            points: 0,
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient.collection(AuthConst.users).doc(_authClient.currentUser?.uid).update(data);
  }
}
