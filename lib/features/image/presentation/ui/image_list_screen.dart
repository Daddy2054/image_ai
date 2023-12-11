import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/image_controller.dart';
import 'image_generation_screen.dart';

class ImageListScreen extends ConsumerStatefulWidget {
  const ImageListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends ConsumerState<ImageListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(imageControllerProvider.notifier).listenImageEntity();
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(
      imageControllerProvider.select((value) => value.imageModels),
    );

    return Scaffold(
      appBar: AppBar(),
      body: images.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final image = data[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Text(image.dateTime),
                          ],
                        ),
                        Image.memory(image.image),
                        Text(image.timeLapsed),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (e, s) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Invalidates the state of the provider, causing it to refresh.
          ref.invalidate(imageControllerProvider);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ImageGenerationScreen(),
            ),
          );
        },
        label: const Text('Image'),
        icon: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
