import 'package:flutter/material.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';

class ShowsProvider extends RequestProvider<Show> {
  ShowsProvider(this.repository);

  ShowsRepository repository;

  bool _showsHidden = false;
  bool get showsHidden => _showsHidden;

  Show? _selectedShow;

  Show? get selectedShow => _selectedShow;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void toggleShowsHidden() {
    _showsHidden = !_showsHidden;
    notifyListeners();
  }

  void onShowClicked(Show show) {
    _selectedShow = show;
  }

  Future<List<Show>> get shows async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _showsHidden ? List<Show>.empty() : Show.allShows,
    );
  }
}
