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

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

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
                            _SlideInFromRightText(widget.show.description, _controller),
                            const SizedBox(height: 20.0),
                            ShowReviews(animationController: _controller),
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
                child: _SlideUpTransition(
                  controller: _controller,
                  child: ElevatedButton(
                    child: const Text('Write a Review'),
                    onPressed: () async => await _showReviewsBottomSheet(providerContext),
                  ),
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

class _SlideInFromRightText extends StatelessWidget {
  _SlideInFromRightText(String text, AnimationController controller, {Key? key}) : super(key: key) {
    _text = text;
    _controller = controller;
  }

  late final String _text;
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return _SlideTransition(
      child: Text(
        _text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      controller: _controller,
      interval: const Interval(
        0.0,
        0.4,
        curve: Curves.ease,
      ),
      begin: const Offset(200.0, 0.0),
    );
  }
}

class _SlideUpTransition extends StatelessWidget {
  _SlideUpTransition({
    Key? key,
    required AnimationController controller,
    required Widget child,
  }) : super(key: key) {
    _controller = controller;
    _child = child;
  }

  late final Widget _child;
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return _SlideTransition(
      child: _child,
      controller: _controller,
      interval: const Interval(
        0.6,
        1,
        curve: Curves.ease,
      ),
      begin: const Offset(
        0.0,
        200.0,
      ),
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

class _SlideTransition extends StatelessWidget {
  _SlideTransition({
    Key? key,
    required Widget child,
    required AnimationController controller,
    Offset begin = Offset.zero,
    Offset end = Offset.zero,
    required Interval interval,
  }) : super(key: key) {
    _child = child;
    _controller = controller;
    _beginOffset = begin;
    _endOffset = end;
    _interval = interval;
  }

  late final Widget _child;
  late final AnimationController _controller;
  late final Offset _beginOffset;
  late final Offset _endOffset;
  late final Interval _interval;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final Animation<Offset> _offsetAnimation = Tween<Offset>(
          begin: _beginOffset,
          end: _endOffset,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: _interval,
          ),
        );

        return SlideTransition(
          position: _offsetAnimation,
          child: _OpacityTransition(
            controller: _controller,
            interval: const Interval(0.3, 1, curve: Curves.ease),
            child: _child,
          ),
        );
      },
    );
  }
}
