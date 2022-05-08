import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/models/user.dart';
import 'domain/data_holder/auth_info_holder.dart';
import 'ui/tv_shows_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageRepo = AuthInfoHolder();

  await Hive.initFlutter();

  User? user;

  if (await storageRepo.authInfo != null && await Hive.boxExists('user')) {
    final box = await Hive.openBox('user');

    user = User.fromHive(box);
  }

  runApp(TVShowsApp(
    user: user,
  ));
}
