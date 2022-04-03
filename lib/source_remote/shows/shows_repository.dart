import 'package:tv_shows/common/models/user_review.dart';

import '../../common/models/review.dart';
import '../../common/models/show.dart';

abstract class ShowsRepository {
  Future<List<Show>> getShows();

  Future<List<Review>> getReviewsForShow(int showId);

  Future<Review> submitReviewForShow({required UserReview userReview});
}
