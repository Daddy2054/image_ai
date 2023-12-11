

import 'package:flutter/material.dart';

mixin LoadingOverlay {

  OverlayEntry showLoadingOverlay(BuildContext context, OverlayEntry? overlayEntry) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return const Align(
          alignment: Alignment.center,
          child:  CircularProgressIndicator.adaptive(),
        );        
      },
    );

    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry);

    return overlayEntry;
  }
}