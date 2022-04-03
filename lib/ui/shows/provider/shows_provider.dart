import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';

class ShowsProvider extends RequestProvider<Show> {
  ShowsProvider(this._repository);

  final ShowsRepository _repository;

  bool _showsHidden = false;
  bool get showsHidden => _showsHidden;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void toggleShowsHidden() {
    _showsHidden = !_showsHidden;
    notifyListeners();
  }

  Future<List<Show>?> get shows async {
    try {
      return await _repository.getShows();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }

    return null;
  }
}
