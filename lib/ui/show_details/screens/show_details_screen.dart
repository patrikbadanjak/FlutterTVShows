import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';

import '../components/show_reviews.dart';

class ShowDetailsScreen extends StatelessWidget {
  const ShowDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ShowsProvider>(
        builder: (context, provider, child) {
          final show = provider.selectedShow;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 10.0,
                pinned: true,
                expandedHeight: 120.0,
                titleTextStyle: Theme.of(context).textTheme.headline5,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(show!.name),
                  expandedTitleScale: 1.5,
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
                          Container(
                            height: 250.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(show.imageUrl).image,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
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
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            child: const Text('Write a Review'),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
