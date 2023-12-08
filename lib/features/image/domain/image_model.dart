

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';

@freezed
class ImageModel with _$ImageModel {

  factory ImageModel({
    required Uint8List image,
    required String dateTime,
    required String timeLapsed,
  }) = _ImageModel;
}