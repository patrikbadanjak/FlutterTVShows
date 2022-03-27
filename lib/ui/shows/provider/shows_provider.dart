import 'package:tv_shows/common/models/review.dart';
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

  Future<List<Show>?> get shows async {
    try {
      return await repository.getShows();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }

    return null;
  }

  Future<List<Review>?> get reviews async {
    try {
      return await repository.getReviewsForShow(_selectedShow?.id ?? -1);
    } on Exception catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }

    return null;
  }
}
