import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/domain/data_holder/auth_info_holder.dart';
import 'package:tv_shows/source_remote/auth/auth_repository_impl.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';
import 'package:tv_shows/source_remote/shows/shows_repository_impl.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

import '../source_remote/auth/auth_repository.dart';
import 'login_register/screens/login_screen.dart';

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthInfoHolder()),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read<AuthInfoHolder>()),
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
        home: const LoginScreen(),
      ),
    );
  }
}
