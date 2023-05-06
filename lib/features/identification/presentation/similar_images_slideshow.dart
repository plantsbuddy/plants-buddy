import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class SimilarImagesSlideShow extends StatelessWidget {
  const SimilarImagesSlideShow(this.images, {Key? key}) : super(key: key);

  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      autoPlayInterval: 10000,
      isLoop: true,
      children: images
          .map((image) => Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ))
          .toList(),
    );
  }
}
