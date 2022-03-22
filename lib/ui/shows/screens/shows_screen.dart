import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/shows/components/show_list.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shows'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Consumer<ShowsProvider>(
              builder: (context, provider, child) {
                return OutlinedButton(
                  onPressed: () => provider.toggleShowsHidden(),
                  child: Text(provider.showsHidden ? 'Show' : 'Hide'),
                );
              },
            ),
          ),
        ],
      ),
      body: const ShowList(),
    );
  }
}
