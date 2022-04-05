import 'package:flutter/material.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item.dart';
import 'package:tv_shows/ui/show_details/components/show_rating.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';

import '../../../common/models/review.dart';
import '../../../common/utility/state/consumer_listener.dart';

class ShowReviews extends StatelessWidget {
  const ShowReviews({Key? key, required animationController})
      : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return ConsumerListener<ReviewProvider>(
      listener: (context, provider) {},
      builder: (context, provider) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Reviews',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16.0),
            FutureBuilder(
              future: provider.reviews,
              builder: (context, AsyncSnapshot<List<Review>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return _OpacityTransition(
                      controller: _animationController,
                      interval: const Interval(
                        0.3,
                        0.7,
                        curve: Curves.ease,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowRating(
                            averageRating: provider.show.averageRating,
                            numOfReviews: provider.show.numOfReviews,
                          ),
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
                      ),
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
        );
      },
    );
  }
}

class _OpacityTransition extends StatelessWidget {
  _OpacityTransition({
    Key? key,
    required Widget child,
    required AnimationController controller,
    required Interval interval,
  }) : super(key: key) {
    _child = child;
    _controller = controller;
    _interval = interval;
  }

  late final Widget _child;
  late final AnimationController _controller;
  late final Interval _interval;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final opacity = CurvedAnimation(parent: _controller, curve: _interval).drive(
          Tween<double>(
            begin: 0.25,
            end: 1,
          ),
        );

        return Opacity(
          opacity: opacity.value,
          child: _child,
        );
      },
    );
  }
}
