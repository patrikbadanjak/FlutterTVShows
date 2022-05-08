import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/ui/shows/components/show_list.dart';
import 'package:tv_shows/ui/shows/provider/user_provider.dart';
import 'package:tv_shows/ui/shows/screens/user_profile_screen.dart';

import '../../../source_remote/auth/auth_repository.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.0,
            title: SizedBox(
              height: 100.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Shows',
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  width: 40.0,
                  height: 40.0,
                  child: const _ProfilePicture(),
                ),
                onTap: () => _showModalBottomSheet(context),
              )
            ],
          ),
          body: const ShowList(),
        );
      },
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const UserProfileScreen();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Image.network(
          provider.user?.imageUrl ?? Assets.images.icProfilePlaceholder.path,
        );
      },
    );
  }
}
