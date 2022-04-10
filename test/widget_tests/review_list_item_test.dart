import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item.dart';

import 'material_app_and_scaffold.dart';

void main() {
  group('Visuals', () {
    testWidgets('Review list item contains a comment', (WidgetTester tester) async {
      final someUser = User('1', 'user@example.com', null);

      final someReview = Review(id: 1, comment: 'Some comment', rating: 5, showId: 1, user: someUser);

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ReviewListItem(
            review: someReview,
          ),
        ),
      );

      final commentFinder = find.text(someReview.comment);

      expect(commentFinder, findsOneWidget);
    });

    testWidgets('Review list item doesn\'t contain a comment', (WidgetTester tester) async {
      final someUser = User('1', 'user@example.com', null);

      final someReview = Review(id: 1, comment: '', rating: 5, showId: 1, user: someUser);

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ReviewListItem(
            review: someReview,
          ),
        ),
      );

      final commentFinder = find.text(someReview.comment);

      expect(commentFinder, findsNothing);
    });

    testWidgets('Review list item contains rating', (WidgetTester tester) async {
      final someUser = User('1', 'user@example.com', null);

      final someReview = Review(id: 1, comment: 'Some comment', rating: 5, showId: 1, user: someUser);

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ReviewListItem(
            review: someReview,
          ),
        ),
      );

      final reviewFinder = find.text(someReview.rating.toString());

      expect(reviewFinder, findsOneWidget);
    });
  });
}
