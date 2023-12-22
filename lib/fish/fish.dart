import 'package:flutter/material.dart';

class FishAssetsImage extends StatelessWidget {
  String image;
  VoidCallback onTap;

  FishAssetsImage({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          image,
          height: 280,
        ),
      ),
    );
  }
}
