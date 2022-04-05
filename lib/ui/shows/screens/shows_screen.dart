import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/ui/shows/components/show_list.dart';
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
                  child: _ProfilePicture(
                    authRepository: provider,
                  ),
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
  const _ProfilePicture({Key? key, required this.authRepository}) : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return authRepository.user?.imageUrl != null
        ? Image.network(
            authRepository.user!.imageUrl!,
            errorBuilder: (context, object, stacktrace) {
              return Image.asset(Assets.images.icProfilePlaceholder.path);
            },
          )
        : Image.asset(Assets.images.icProfilePlaceholder.path);
  }
}
