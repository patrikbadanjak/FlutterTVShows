import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/ui/shows/components/components.dart';

import 'material_app_and_scaffold.dart';

void main() {
  group('Visuals', () {
    testWidgets('Card contains show name', (WidgetTester tester) async {
      final show = Show(
        id: 1,
        name: 'Ured',
        description: 'Some description',
        numOfReviews: 1,
        averageRating: 5.0,
        imageUrl: 'www.example.com/image.png',
      );

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ShowCard(
            show: show,
            onTap: () {},
          ),
        ),
      );

      final showNameFinder = find.text(show.name);

      expect(showNameFinder, findsOneWidget);
    });

    testWidgets('Card contains show description', (WidgetTester tester) async {
      final show = Show(
        id: 1,
        name: 'Ured',
        description: 'Some description',
        numOfReviews: 1,
        averageRating: 5.0,
        imageUrl: 'www.example.com/image.png',
      );

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ShowCard(
            show: show,
            onTap: () {},
          ),
        ),
      );

      final showDescriptionFinder = find.text(show.description);

      expect(showDescriptionFinder, findsOneWidget);
    });
  });

  group('Interaction', () {
    testWidgets('Tapping a card calls a callback function', (WidgetTester tester) async {
      final show = Show(
        id: 1,
        name: 'Ured',
        description: 'Some description',
        numOfReviews: 1,
        averageRating: 5.0,
        imageUrl: 'www.example.com/image.png',
      );

      bool callbackCalled = false;

      void callbackFunction() => callbackCalled = true;

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: ShowCard(
            show: show,
            onTap: callbackFunction,
          ),
        ),
      );

      final cardFinder = find.byType(ShowCard);

      await tester.tap(cardFinder);

      expect(callbackCalled, true);
    });
  });
}
