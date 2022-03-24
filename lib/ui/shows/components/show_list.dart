import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/ui/shows/components/components.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';

import '../../../common/models/show.dart';
import '../../show_details/screens/show_details_screen.dart';

class ShowList extends StatelessWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.shows,
          builder: (context, AsyncSnapshot<List<Show>> snapshot) {
            if (provider.showsHidden) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.shows.icShowsEmptyState.svg(),
                    const SizedBox(height: 26.0),
                    Text(
                      'Your shows are not showing. Get it?',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: const Color(0xFF808080),
                          ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) => ShowCard(
                  show: snapshot.data![index],
                  onTap: () {
                    provider.onShowClicked(snapshot.data![index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ShowDetailsScreen();
                        },
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16.0,
                ),
                itemCount: snapshot.data?.length ?? 0,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
