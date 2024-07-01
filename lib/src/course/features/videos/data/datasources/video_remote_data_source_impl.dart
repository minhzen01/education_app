import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_source.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoRemoteDataSourceImpl extends VideoRemoteDataSource {
  const VideoRemoteDataSourceImpl(
    this._auth,
    this._firestore,
    this._storage,
  );

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  Future<void> addVideo(VideoEntity videoEntity) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final videoRef = _firestore.collection('courses').doc(videoEntity.courseId).collection('videos').doc();
      var videoModel = (videoEntity as VideoModel).copyWith(id: videoRef.id);
      if (videoModel.thumbnailIsFile) {
        final thumbnailFileRef = _storage.ref().child(
              'courses/${videoModel.courseId}/videos/${videoRef.id}/thumbnail',
            );
        await thumbnailFileRef.putFile(File(videoModel.thumbnail!)).then(
          (value) async {
            final url = await value.ref.getDownloadURL();
            videoModel = videoModel.copyWith(thumbnail: url);
          },
        );
      }
      await videoRef.set(videoModel.toMap());
      await _firestore.collection('courses').doc(videoEntity.courseId).update({
        'numberOfVideos': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<VideoModel>> getVideos(String courseId) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final videos = await _firestore.collection('courses').doc(courseId).collection('videos').get();

      return videos.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }
}
