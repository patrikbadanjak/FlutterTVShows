import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';
import 'package:tv_shows/ui/show_details/screens/write_review_screen.dart';

import '../../../common/models/show.dart';
import '../components/show_reviews.dart';

class ShowDetailsScreen extends StatefulWidget {
  const ShowDetailsScreen({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Review submitted successfully',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
        duration: const Duration(
          seconds: 2,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
      create: (_) => ReviewProvider(context.read<ShowsRepository>(), show: widget.show),
      child: Builder(
        builder: (providerContext) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 10.0,
                  pinned: true,
                  stretch: true,
                  backgroundColor: const Color(0xFF979797),
                  iconTheme: const IconThemeData(color: Colors.white),
                  expandedHeight: 220.0,
                  titleTextStyle: Theme.of(context).textTheme.headline5,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'show_image${widget.show.id}',
                      child: CachedNetworkImage(
                        imageUrl: widget.show.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      widget.show.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    expandedTitleScale: 1.7,
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            Text(
                              show.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(height: 20.0),
                            const ShowReviews(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  child: const Text('Write a Review'),
                  onPressed: () async => await showReviews(providerContext),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showReviewsBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context2) => _buildReviewsBottomSheet(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
    );

    if (result is bool && result == true) {
      _showSuccessSnackbar(context);
    }
  }

  Widget _buildReviewsBottomSheet(BuildContext context) {
    var provider = context.read<ReviewProvider>();
    return WriteReviewScreen(
      provider: provider,
    );
  }
}
