import 'package:flutter/material.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/common/utility/state/consumer_listener.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/ui/shows/components/components.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';

import '../../../common/models/show.dart';
import '../../show_details/screens/show_details_screen.dart';

class ShowList extends StatelessWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConsumerListener<ShowsProvider>(
      listener: (context, provider) {
        if (provider.errorMessage.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(provider.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, provider) {
        return FutureBuilder(
          future: provider.shows,
          builder: (context, AsyncSnapshot<List<Show>?> snapshot) {
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
              return RefreshIndicator(
                color: Theme.of(context).primaryColor,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (context, index) => ShowCard(
                    key: Key(snapshot.data![index].id.toString()),
                    show: snapshot.data![index],
                    onTap: () {
                      final Show show = snapshot.data![index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShowDetailsScreen(show: show);
                          },
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16.0,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                ),
                onRefresh: () async => provider.shows,
              );
            } else if (provider.errorMessage.isNotEmpty) {
              return Center(
                child: Text('Error: ${provider.errorMessage}'),
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
