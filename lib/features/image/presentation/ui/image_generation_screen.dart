import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/mixin/loading_overlay.dart';
import '../controller/image_controller.dart';
import 'widget/image_widget.dart';

class ImageGenerationScreen extends ConsumerStatefulWidget {
  const ImageGenerationScreen({Key? key}) : super(key: key);

  @override
  ImageGenerationScreenState createState() => ImageGenerationScreenState();
}

class ImageGenerationScreenState extends ConsumerState<ImageGenerationScreen>
    with LoadingOverlay {
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formKey = GlobalKey();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listener();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DALL-E'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ImageWidget(),
              const SizedBox(
                height: 16.0,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter your image description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Image description is empty.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              FilledButton.tonal(
                onPressed: () {
                  _generateAIImage();
                },
                child: const Text('Generate AI Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateAIImage() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      ref
          .read(imageControllerProvider.notifier)
          .generateImage(_controller.text);
    }
  }

  void _listener() {
    ref.listen(imageControllerProvider.select((value) => value.isLoading),
        (previous, next) {
      if (next) {
        _overlayEntry = showLoadingOverlay(context, _overlayEntry);
      } else {
        _overlayEntry?.remove();
        _overlayEntry?.dispose();
      }
    });
  }
}
