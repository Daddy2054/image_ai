// ignore_for_file: unused_catch_stack

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../common/exception/failure.dart';
import '../../../../core/local/db/isar_provider.dart';
import '../../../../core/local/entity/image_entity.dart';
import '../api/image_api_service.dart';
import '../dto/image_response.dart';
import 'iimage_repository.dart';

final imageRepositoryProvider = Provider<IImageRepository>((ref) {
  final imageApiService = ref.watch(imageApiServiceProvider);
  final isar = ref.watch(isarProvider);

  return ImageRepository(
    imageApiService: imageApiService,
    isar: isar,
  );
});

final class ImageRepository implements IImageRepository {
  final ImageApiService _imageApiService;
  final Isar? _isar;

  ImageRepository({
    required ImageApiService imageApiService,
    required Isar? isar,
  })  : _imageApiService = imageApiService,
        _isar = isar;

  @override
  Future<ImageResponse> generateImage(Map<String, dynamic> body) async {
    try {
      final response = await _imageApiService.generateImage(body);

      return response;
    } on DioException catch (e) {
      throw Failure(
        message: e.response?.data['message'].toString() ??
            'Something went wrong: ${e.error} : ${e.response?.statusCode}',
      );
    }
  }

  @override
  Stream<List<ImageEntity>?> listenImageEntity() async* {
    try {
      final result = _isar?.imageEntitys
          .where(sort: Sort.desc)
          .anyId()
          .watch(fireImmediately: true);

      yield* result ?? Stream<List<ImageEntity>>.value([]);
    } on IsarError catch (e, s) {
      throw Failure(message: e.message, stackTrace: s);
    }
  }

  @override
  Future<int?> writeToDb<T>(T value) async {
    int? id;

    try {
      await _isar?.writeTxn(() async {
        id = await _isar?.imageEntitys.put(value as ImageEntity);
      });

      return id;
    } on IsarError catch (e, s) {
      rethrow;
    }
  }
}
