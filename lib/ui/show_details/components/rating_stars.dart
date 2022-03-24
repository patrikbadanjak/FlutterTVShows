import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars(double averageRating, {Key? key})
      : _averageRating = averageRating,
        super(key: key);

  final double _averageRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          return Icon(index < _averageRating
              ? _averageRating < index + 1
                  ? Icons.star_half
                  : Icons.star
              : Icons.star_border);
        },
      ),
    );
  }
}
