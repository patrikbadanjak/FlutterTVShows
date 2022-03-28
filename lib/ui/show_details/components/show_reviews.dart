import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';

import '../../../common/models/review.dart';
import 'show_rating.dart';

class ShowReviews extends StatelessWidget {
  const ShowReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Reviews',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16.0),
          FutureBuilder(
            future: provider.getReviewsForShow(),
            builder: (context, AsyncSnapshot<List<Review>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowRating(averageRating: provider.show.averageRating, numOfReviews: provider.show.numOfReviews),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Review review = snapshot.data![index];
                          return ReviewListItem(
                            key: Key(review.id.toString()),
                            review: review,
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          indent: 10.0,
                          endIndent: 10.0,
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    height: 70.0,
                    child: Center(
                      child: Text('No reviews yet.'),
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
