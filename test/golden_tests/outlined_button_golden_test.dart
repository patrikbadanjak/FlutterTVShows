import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

void main() {
  testGoldens('Outlined button with no focus renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: 'email@example.com',
            labelText: 'Email',
          ),
          textInputAction: TextInputAction.next,
        ),
      ),
    );

    await tester.pumpWidgetBuilder(
      inputField,
      wrapper: materialAppWrapper(theme: TVShowsTheme.light()),
      surfaceSize: const Size(250.0, 375.0),
    );

    await screenMatchesGolden(tester, 'email_input_field');
  });

  testGoldens('Outlined button with focus renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: 'email@example.com',
            labelText: 'Email',
          ),
          textInputAction: TextInputAction.next,
        ),
      ),
    );

    final builder = DeviceBuilder()
      ..addScenario(
          name: 'Tap input field',
          widget: inputField,
          onCreate: (scenarioWidgetKey) async {
            final finder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(TextFormField),
            );
            expect(finder, findsOneWidget);

            await tester.tap(finder);
          });

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: TVShowsTheme.light(),
      ),
    );

    await screenMatchesGolden(tester, 'email_input_field_focused');
  });
}
