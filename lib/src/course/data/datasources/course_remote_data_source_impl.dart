import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/src/chat/data/models/group_model.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseRemoteDataSourceImpl extends CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl(
    this._firestore,
    this._storage,
    this._auth,
  );

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  @override
  Future<void> addCourse(Course course) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final courseRef = _firestore.collection('courses').doc();
      final groupRef = _firestore.collection('groups').doc();

      var courseModel = (course as CourseModel).copyWith(
        id: courseRef.id,
        groupId: groupRef.id,
      );

      if (courseModel.imageIsFile) {
        final imageRef = _storage.ref().child('courses/${courseModel.id}/profile_image/${courseModel.title}-pfp');

        await imageRef.putFile(File(course.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      await courseRef.set(courseModel.toMap());

      final group = GroupModel(
        id: groupRef.id,
        name: course.title,
        courseId: courseRef.id,
        members: const [],
        groupImageUrl: courseModel.image,
      );

      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: e.code, message: e.message ?? 'Unknown error occurred');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(statusCode: '505', message: e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }
      return _firestore.collection('courses').get().then((value) => value.docs.map((e) => CourseModel.fromMap(e.data())).toList());
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: e.code, message: e.message ?? 'Unknown error occurred');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(statusCode: '505', message: e.toString());
    }
  }
}
