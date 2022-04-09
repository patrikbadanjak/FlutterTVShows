import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/common/utility/state/request_state.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';
import 'package:tv_shows/ui/show_details/provider/write_review_provider.dart';

import 'write_review_provider_test.mocks.dart';

@GenerateMocks([ReviewProvider, ShowsRepository])
void main() {
  final reviewProvider = MockReviewProvider();
  final showsRepository = MockShowsRepository();

  when(reviewProvider.show).thenReturn(
    Show(
      id: 1,
      name: 'Ured',
      description: 'Ured show',
      numOfReviews: 1,
      averageRating: 5,
      imageUrl: 'some_image.png',
    ),
  );

  when(
    showsRepository.submitReviewForShow(
      userReview: argThat(
        isNotNull,
        named: 'userReview',
      ),
    ),
  ).thenAnswer(
    (_) async => await Future.value(
      Review(
        id: 1,
        showId: 1,
        rating: 5,
        comment: 'Some comment',
        user: User('1', 'someone@example.com', null),
      ),
    ),
  );

  when(reviewProvider.fetchReviews()).thenAnswer(
    (realInvocation) async => await Future.delayed(
      const Duration(milliseconds: 10),
      () => List<Review>.empty(),
    ),
  );

  final writeReviewProvider = WriteReviewProvider(reviewProvider, showsRepository);

  group('Update rating and comment values', () {
    test('Set rating to some value', () {
      writeReviewProvider.updateRating(5.0);
      expect(writeReviewProvider.rating, 5.0);
    });

    test('Set comment to some value', () {
      writeReviewProvider.updateComment('Lorem ipsum dolor');
      expect(writeReviewProvider.comment, 'Lorem ipsum dolor');
    });
  });

  group('Review submissions', () {
    test('Successful review submission with both rating and comment', () async {
      writeReviewProvider.updateRating(5.0);
      writeReviewProvider.updateComment('Some comment');

      await writeReviewProvider.onSubmitPressed();
      expect(writeReviewProvider.state is RequestStateSuccess, true);
    });

    test('Successful review submission with rating but without comment', () async {
      writeReviewProvider.updateRating(5);
      writeReviewProvider.updateComment('');

      await writeReviewProvider.onSubmitPressed();
      expect(writeReviewProvider.state is RequestStateSuccess, true);
    });

    test('Request state is set to loading while waiting for respones', () {
      writeReviewProvider.updateRating(5);
      writeReviewProvider.updateComment('');

      writeReviewProvider.onSubmitPressed();
      expect(writeReviewProvider.state is RequestStateLoading, true);
    });
  });
}
