import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_source.dart';
import 'package:education_app/src/course/features/materials/data/models/resource_model.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MaterialRemoteDataSourceImpl extends MaterialRemoteDataSource {
  const MaterialRemoteDataSourceImpl(
    this._auth,
    this._firestore,
    this._storage,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  Future<void> addMaterial(ResourceEntity material) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final materialRef = _firestore.collection('courses').doc(material.courseId).collection('materials').doc();
      var materialModel = (material as ResourceModel).copyWith(id: materialRef.id);
      if (materialModel.isFile) {
        final materialFileRef = _storage.ref().child(
              'courses/${materialModel.courseId}/materials/${materialModel.isFile}/material',
            );
        await materialFileRef.putFile(File(materialModel.fileURL)).then(
          (value) async {
            final url = await value.ref.getDownloadURL();
            materialModel = materialModel.copyWith(fileURL: url);
          },
        );
      }
      await materialRef.set(materialModel.toMap());

      await _firestore.collection('courses').doc(material.courseId).update({
        'numberOfMaterials': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '500',
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<ResourceModel>> getMaterials(String courseId) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);
      final materialsRef = _firestore.collection('courses').doc(courseId).collection('materials');
      final materials = await materialsRef.get();
      return materials.docs.map((e) => ResourceModel.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '500',
        message: e.toString(),
      );
    }
  }
}
