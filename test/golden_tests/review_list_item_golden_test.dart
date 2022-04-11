import 'dart:ui';

import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/common/models/user.dart';
import 'package:tv_shows/ui/show_details/components/review_list_item.dart';

void main() {
  testGoldens('Review list items should look correct', (tester) async {
    await loadAppFonts();

    final someUser = User('1', 'email@example.com', null);

    final builder = GoldenBuilder.column()
      ..addScenario(
        'Review 1',
        ReviewListItem(
          review: Review(id: 1, comment: 'First comment', rating: 5, showId: 1, user: someUser),
        ),
      )
      ..addScenario(
        'Review 2',
        ReviewListItem(
          review: Review(id: 2, comment: 'Second comment', rating: 5, showId: 1, user: someUser),
        ),
      )
      ..addScenario(
        'Review 3',
        ReviewListItem(
          review: Review(id: 3, comment: 'Third comment', rating: 5, showId: 1, user: someUser),
        ),
      )
      ..addScenario(
        'Review 4',
        ReviewListItem(
          review: Review(id: 4, comment: '', rating: 5, showId: 1, user: someUser),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(
        300,
        500,
      ),
    );
    await screenMatchesGolden(tester, 'shows_column');
  });
}
