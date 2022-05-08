import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/domain/data_holder/auth_info_holder.dart';
import 'package:tv_shows/source_remote/auth/auth_repository_impl.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';
import 'package:tv_shows/source_remote/shows/shows_repository_impl.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';
import 'package:tv_shows/ui/shows/provider/user_provider.dart';
import 'package:tv_shows/ui/shows/screens/shows_screen.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

import '../source_remote/auth/auth_repository.dart';
import 'login_register/screens/login_screen.dart';

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key, User? user})
      : _user = user,
        super(key: key);

  final User? _user;

  @override
  Widget build(BuildContext context) {
    Widget firstScreen = _user == null ? const LoginScreen() : const ShowsScreen();

    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthInfoHolder()),
        ChangeNotifierProvider(create: (_) => UserProvider(user: _user)),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read<AuthInfoHolder>(), context.read<UserProvider>()),
        ),
        Provider<ShowsRepository>(
          create: (context) => ShowsRepositoryImpl(
            context.read<AuthInfoHolder>(),
          ),
        ),
        ChangeNotifierProvider<ShowsProvider>(
          create: (context) => ShowsProvider(
            context.read<ShowsRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TV Shows',
        theme: TVShowsTheme.light(),
        home: firstScreen,
      ),
    );
  }
}
