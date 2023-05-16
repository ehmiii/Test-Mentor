import 'package:flutter/material.dart';

class BottomSheetCameraAndGallery extends StatelessWidget {
  VoidCallback cameraFuction;
  VoidCallback galleryFuction;
  BottomSheetCameraAndGallery({
    super.key,
    required this.cameraFuction,
    required this.galleryFuction,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: cameraFuction,
            child: const Text(
              "Camera",
            ),
          ),
          ElevatedButton(
            onPressed: galleryFuction,
            child: const Text(
              "Gallery",
            ),
          ),
        ],
      ),
    );
  }
}
