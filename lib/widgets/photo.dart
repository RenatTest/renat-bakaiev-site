// ignore_for_file: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Photo extends StatelessWidget {
  const Photo({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: HexColor("#ff4119"),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
              radius: 90,
            ),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
                color: HexColor("#ff4119"),
              ),
            ),
          ),
        )
      ],
    );
  }
}
