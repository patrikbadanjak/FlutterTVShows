import 'package:flutter/material.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item.dart';

import '../../../common/models/review.dart';
import 'show_rating.dart';

class ShowReviews extends StatelessWidget {
  const ShowReviews({Key? key, required this.reviews}) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Reviews',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 16.0),
        reviews.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShowRating(),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ReviewListItem(review: reviews[index]),
                    separatorBuilder: (context, index) => const Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    itemCount: reviews.length,
                  ),
                ],
              )
            : const SizedBox(
                height: 70.0,
                child: Center(
                  child: Text('No reviews yet.'),
                ),
              ),
      ],
    );
  }
}
