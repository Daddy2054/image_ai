import 'dart:typed_data';

import 'package:flutter/material.dart';

class PinchToZoom extends StatefulWidget {
  final Uint8List image;
  const PinchToZoom({Key? key, required this.image}) : super(key: key);

  @override
  PinchToZoomState createState() => PinchToZoomState();
}

class PinchToZoomState extends State<PinchToZoom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            minScale: 1,
            maxScale: 4,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.memory(widget.image),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: _backIcon(),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Icon _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const Icon(
          Icons.arrow_back,
          color: Colors.white,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        );
    }
  }
}
