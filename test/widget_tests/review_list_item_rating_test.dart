import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item_rating.dart';

import 'material_app_and_scaffold.dart';

void main() {
  group('Visuals', () {
    testWidgets('Actual rating is displayed', (WidgetTester tester) async {
      const int rating = 5;

      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: ReviewListItemRating(rating),
        ),
      );

      final ratingFinder = find.text(rating.toString());

      expect(ratingFinder, findsOneWidget);
    });

    testWidgets('Star icon is displayed', (WidgetTester tester) async {
      const int rating = 5;

      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: ReviewListItemRating(rating),
        ),
      );

      final starIconFinder = find.byIcon(Icons.star);

      expect(starIconFinder, findsOneWidget);
    });
  });
}
