

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/image_service.dart';
import '../state/image_state.dart';

final imageControllerProvider = AutoDisposeNotifierProvider<ImageController, ImageState>(
  ImageController.new
);

class ImageController extends AutoDisposeNotifier<ImageState> {

  @override
  ImageState build() {
    return ImageState();
  }

  Future<void> generateImage(String description) async {
    state = state.copyWith(isLoading: true, errorMsg: null);

    final body = {
      "prompt": description,
      "n": 1,
      "size": "1024x1024",
      "response_formate":"b64_json"
    };

    final result = await ref.read(imageServiceProvider)
      .generateImage(body);

    result.when(
      (success) {
        state = state.copyWith(
          imageModel: success,
          isLoading: false,
        );
      }, 
      (error) {
        state = state.copyWith(
          errorMsg: error.message,
          isLoading: false,
        );
      },
    );
  }

  void listenImageEntity() {

    final result = ref.read(imageServiceProvider)
      .listenImageEntity();

    result.listen((event) { 
      state = state.copyWith(
        isLoading: false,
        imageModels: AsyncData(event)
      );
    });
  }

}