import 'package:flutter/material.dart';

import 'rating_stars.dart';

class ShowRating extends StatelessWidget {
  const ShowRating({
    Key? key,
    required this.averageRating,
    required this.numOfReviews,
  }) : super(key: key);

  final double averageRating;
  final int numOfReviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$numOfReviews review(s), $averageRating average'.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: const Color(0xFF999999),
              ),
        ),
        const SizedBox(height: 8.0),
        IconTheme(
          data: IconThemeData(
            color: Theme.of(context).primaryColor,
            size: 23.0,
          ),
          child: RatingStars(
            averageRating,
          ),
        ),
      ],
    );
  }
}
