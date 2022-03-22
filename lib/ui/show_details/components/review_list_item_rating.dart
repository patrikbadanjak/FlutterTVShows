import 'package:flutter/material.dart';

class ReviewListItemRating extends StatelessWidget {
  const ReviewListItemRating(int rating, {Key? key})
      : _rating = rating,
        super(key: key);

  final int _rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_rating.toString()),
        Icon(
          Icons.star,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
