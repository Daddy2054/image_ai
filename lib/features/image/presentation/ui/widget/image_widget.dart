
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/image_controller.dart';

class ImageWidget extends ConsumerWidget {
const ImageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final imageModel = ref.watch(imageControllerProvider
      .select((value) => value.imageModel));

    if (imageModel != null) {
      return Image.memory(imageModel.image);
    }
    else {
      return const SizedBox.shrink();
    } 
  }
}