import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/gen/assets.gen.dart';

import 'review_list_item_rating.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({Key? key, required this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //CircleAvatar bacao error stalno
            Image.asset(
              Assets.images.icProfilePlaceholder.path,
              width: 50.0,
              height: 50.0,
            ),
            const SizedBox(width: 17.0),
            Expanded(
              flex: 3,
              child: Text(
                review.userEmail,
                style: GoogleFonts.roboto(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 17.0),
            ReviewListItemRating(review.rating),
          ],
        ),
        review.comment.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 17.0),
                  Text(review.comment),
                ],
              )
            : Container(),
      ],
    );
  }
}
