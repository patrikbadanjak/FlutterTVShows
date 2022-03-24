import 'package:flutter/material.dart';
import 'package:tv_shows/common/models/show.dart';

class ShowsProvider extends ChangeNotifier {
  bool _showsHidden = false;
  bool get showsHidden => _showsHidden;

  Show? _selectedShow;

  Show? get selectedShow => _selectedShow;

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
