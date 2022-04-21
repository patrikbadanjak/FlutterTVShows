import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tv_shows/ui/login_register/components/password_input_field.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

void main() {
  testGoldens('Password field with no focus renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: const Center(
        child: PasswordInputField(
          labelText: 'Password',
          validated: false,
        ),
      ),
    );

    await tester.pumpWidgetBuilder(
      inputField,
      wrapper: materialAppWrapper(theme: TVShowsTheme.light()),
      surfaceSize: const Size(250.0, 375.0),
    );

    await screenMatchesGolden(tester, 'password_input_field');
  });

  testGoldens('Password field with focus renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: const Center(
        child: PasswordInputField(
          labelText: 'Password',
          validated: false,
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
              matching: find.byType(PasswordInputField),
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

    await screenMatchesGolden(tester, 'password_input_field_focused');
  });

  testGoldens('Password field with obscure text renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: const Center(
        child: PasswordInputField(
          labelText: 'Password',
          validated: false,
        ),
      ),
    );

    final builder = DeviceBuilder()
      ..addScenario(
          name: 'Input some text',
          widget: inputField,
          onCreate: (scenarioWidgetKey) async {
            final finder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(PasswordInputField),
            );
            expect(finder, findsOneWidget);

            await tester.enterText(finder, 'some_password');
            await tester.pump();

            await tester.tap(finder);
          });

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: TVShowsTheme.light(),
      ),
    );

    await screenMatchesGolden(tester, 'password_input_field_with_obscure_text');
  });

  testGoldens('Password field with non-obscure text renders correctly', (WidgetTester tester) async {
    await loadAppFonts();

    final inputField = Container(
      color: const Color(0xFF52368C),
      child: const Center(
        child: PasswordInputField(
          labelText: 'Password',
          validated: false,
        ),
      ),
    );

    final builder = DeviceBuilder()
      ..addScenario(
          name: 'Input some text',
          widget: inputField,
          onCreate: (scenarioWidgetKey) async {
            final fieldFinder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(PasswordInputField),
            );
            expect(fieldFinder, findsOneWidget);

            await tester.enterText(fieldFinder, 'some_password');
            await tester.pump();

            final iconButtonFinder = find.descendant(of: fieldFinder, matching: find.byType(IconButton));
            await tester.tap(iconButtonFinder);

            await tester.pump();

            await tester.tap(fieldFinder);
          });

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: TVShowsTheme.light(),
      ),
    );

    await screenMatchesGolden(tester, 'password_input_field_with_non-obscure_text');
  });
}
