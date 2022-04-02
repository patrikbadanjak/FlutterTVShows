import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/models/user.dart';
import 'domain/data_holder/storage_repository.dart';
import 'ui/tv_shows_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageRepo = StorageRepository();

  await Hive.initFlutter();

  User? user;

  if (await storageRepo.authInfo != null && await Hive.boxExists('user')) {
    final box = await Hive.openBox('user');

    user = User(
      box.get('id'),
      box.get('email'),
      box.get('imageUrl') as String?,
    );
  }

  runApp(TVShowsApp(
    user: user,
  ));
}
