import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';

import 'rating_stars.dart';

class ShowRating extends StatelessWidget {
  const ShowRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(
      builder: (context, provider, child) {
        final show = provider.selectedShow;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${show!.numOfReviews} review(s), ${show.averageRating} average'.toUpperCase(),
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
                show.averageRating,
              ),
            ),
          ],
        );
      },
    );
  }
}
