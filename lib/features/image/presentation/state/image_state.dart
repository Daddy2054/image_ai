
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/image_model.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {

  factory ImageState({
    @Default(false)
    bool isLoading,
    String? errorMsg,
    ImageModel? imageModel,
    @Default(AsyncLoading())
    AsyncValue<List<ImageModel>> imageModels,
  }) = _ImageModel;
}