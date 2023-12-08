

import 'dart:convert';

import 'package:image_ai/common/exception/failure.dart';
import 'package:image_ai/common/extension/date_time_formatter.dart';
import 'package:image_ai/common/extension/int_to_date_time.dart';
import 'package:image_ai/core/local/entity/image_entity.dart';
import 'package:image_ai/features/image/application/iimage_service.dart';
import 'package:image_ai/features/image/data/dto/image_response.dart';
import 'package:image_ai/features/image/data/repository/iimage_repository.dart';
import 'package:image_ai/features/image/domain/image_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:multiple_result/multiple_result.dart';

final class ImageService implements IIMageService {
  final IImageRepository _imageRepository;

  ImageService({
    required IImageRepository imageRepository
  }): _imageRepository = imageRepository;

  @override
  Future<Result<ImageModel, Failure>> generateImage(Map<String, dynamic> body) async {

    try {

      final response = await _imageRepository.generateImage(body);
      
      await writeToDb<ImageEntity>(_mapToImageEntity(response));      

      return Success(_mapToImageModel(response));
      
    } on Failure catch (e) {
      return Error(e);
    }
    
  }

  @override
  Stream<List<ImageModel>> listenImageEntity() async* {

    try {

      final entities = _imageRepository.listenImageEntity().map((event) => event);
      final model = entities.map((event) => _mapToImageModelFromImageEntity(event ?? []));

      yield* model;
      
    } on Failure catch (_) {
      rethrow;
    }
    
  }

  @override
  Future<int?> writeToDb<T>(T value) async {

    try {

      final result = await _imageRepository.writeToDb(value);

      return result;
      
    } on Failure catch (_) {
      rethrow;  
    }
    
  }
  

  List<ImageModel> _mapToImageModelFromImageEntity(List<ImageEntity> entity) {
    return entity.map((e) {
      return ImageModel(
        image: base64Decode(e.image ?? ''), 
        dateTime: e.dateTime.toString(), 
        timeLapsed: Jiffy.parse(e.timeStamp?.toIso8601String() ?? '').fromNow(),
      );
    }).toList();
  }

  ImageModel _mapToImageModel(ImageResponse response) {
    return ImageModel(
      image: base64Decode(response.data.first.base64), 
      dateTime: response.created.toDateTime().toDateTimeString(), 
      timeLapsed: Jiffy.parse(response.created.toDateTime().toIso8601String()).fromNow(),
    );
  }

  ImageEntity _mapToImageEntity(ImageResponse response) {
    return ImageEntity()
      ..image = response.data.first.base64
      ..dateTime = response.created.toDateTime().toDateTimeString()
      ..timeStamp = response.created.toDateTime();
  }
}