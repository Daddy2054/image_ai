

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_response.freezed.dart';
part 'image_response.g.dart';

@freezed
class ImageResponse with _$ImageResponse {
  const factory ImageResponse({
    required int created,
    required List<ImageResponseData> data,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String,dynamic> json) => _$ImageResponseFromJson(json);
}

@freezed
class ImageResponseData with _$ImageResponseData {
  const factory ImageResponseData({
    @JsonKey(name: 'b64_json')
    required String base64    
  }) = _ImageResponseData;

  factory ImageResponseData.fromJson(Map<String,dynamic> json) => _$ImageResponseDataFromJson(json);
  
}