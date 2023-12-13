import 'dart:typed_data';

import 'package:flutter/material.dart';

class ZoomableImageWidget extends StatefulWidget {
  final Uint8List image;

  const ZoomableImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  ZoomableImageWidgetState createState() => ZoomableImageWidgetState();
}

class ZoomableImageWidgetState extends State<ZoomableImageWidget>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _entry;
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() {
        _transformationController.value =
            _animation?.value ?? Matrix4.identity();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildImage();
  }

  Widget buildImage() {
    return InteractiveViewer(
      transformationController: _transformationController,
      clipBehavior: Clip.none,
      minScale: 1,
      maxScale: 4,
      onInteractionStart: (details) {
        if (details.pointerCount < 2) return;

        _showOverlay();
      },
      onInteractionEnd: (details) {
        _removeAnimation();
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.memory(widget.image),
      ),
    );
  }

  void _showOverlay() {
    final size = MediaQuery.of(context).size;
    final renderBox = context.findRenderObject() as RenderBox;

    _entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: renderBox.localToGlobal(Offset.zero).dy,
          left: renderBox.localToGlobal(Offset.zero).dx,
          width: size.width,
          child: buildImage(),
        );
      },
    );

    final overlay = Overlay.of(context);
    if (_entry != null) {
      overlay.insert(_entry!);
    }
  }

  void _removeOverlay() {
    if (_entry != null) {
      _entry?.remove();
      _entry?.dispose();
      _entry = null;
    }
  }

  void _removeAnimation() {
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward(from: 0);
  }
}
