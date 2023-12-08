


import '../../../../core/local/entity/image_entity.dart';
import '../dto/image_response.dart';

abstract interface class IImageRepository {

  Future<ImageResponse> generateImage(Map<String,dynamic> body);

  Future<int?> writeToDb<T>(T value);

  Stream<List<ImageEntity>?> listenImageEntity();


}