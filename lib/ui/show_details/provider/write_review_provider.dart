import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/common/models/user_review.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';

class WriteReviewProvider extends RequestProvider<Review> {
  WriteReviewProvider(ReviewProvider provider, ShowsRepository repository) {
    _reviewProvider = provider;
    _repository = repository;
  }

  late final ReviewProvider _reviewProvider;
  late final ShowsRepository _repository;

  double _rating = 3.0;

  double get rating => _rating;

  String _comment = '';

  String get comment => _comment;

  void updateRating(double value) {
    _rating = value;
    notifyListeners();
  }

  void updateComment(String value) {
    _comment = value;
    notifyListeners();
  }

  Future<void> onSubmitPressed() async {
    await executeRequest(
      requestBuilder: () {
        return _repository.submitReviewForShow(
          userReview: UserReview(
            showId: _reviewProvider.show.id,
            rating: _rating.toInt(),
            comment: _comment,
          ),
        );
      },
    );

    _reviewProvider.fetchReviews();
  }
}
