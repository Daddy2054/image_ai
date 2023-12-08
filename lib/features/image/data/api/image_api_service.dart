
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/remote/network_service.dart';
import '../dto/image_response.dart';

part 'image_api_service.g.dart';

final imageApiServiceProvider = Provider<ImageApiService>((ref) {
  
  final dio = ref.watch(networkServiceProvider);

  return ImageApiService(dio);

});

@RestApi()
abstract class ImageApiService {

  factory ImageApiService(Dio dio) => _ImageApiService(dio);

  @POST('/v1/images/generations')
  Future<ImageResponse> generateImage(@Body() Map<String,dynamic> body);


}