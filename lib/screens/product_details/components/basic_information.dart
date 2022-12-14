import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../config/variables.dart';
import 'image_preview.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.previewLink,
    this.ratingValue,
    this.ratingCount = 0,
  });

  final String productName;
  final String productPrice;
  final List<String> previewLink;
  final double? ratingValue;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImagePreview(previewLink: previewLink),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                productPrice,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        ratingValue == null
            ? const Text("Not rating yet", style: TextStyle(fontSize: 17))
            : _ratingBar(ratingValue: ratingValue!, ratingCount: ratingCount),
      ],
    );
  }

  Widget _ratingBar({
    required double ratingValue,
    int ratingCount = 0,
    double fontSize = 17,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: ratingValue,
              direction: Axis.horizontal,
              itemSize: 30,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Variables.mainColor,
              ),
              onRatingUpdate: (rating) {},
              ignoreGestures: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "$ratingValue",
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "($ratingCount review${ratingCount == 1 ? "" : "s"})",
                style: const TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
