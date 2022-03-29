import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';

import '../../../common/models/review.dart';
import '../../../common/models/show.dart';

class ReviewProvider extends RequestProvider<Review> {
  ReviewProvider(this._repository, {required this.show});

  final ShowsRepository _repository;
  final Show show;

  String errorMessage = '';

  Future<List<Review>?> getReviewsForShow() async {
    try {
      return await _repository.getReviewsForShow(show.id);
    } on Exception catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }

    return null;
  }
}
