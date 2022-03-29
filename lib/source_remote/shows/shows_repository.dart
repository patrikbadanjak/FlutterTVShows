import '../../common/models/review.dart';
import '../../common/models/show.dart';

abstract class ShowsRepository {
  Future<List<Show>> getShows();
  Future<List<Review>> getReviewsForShow(int showId);
}
