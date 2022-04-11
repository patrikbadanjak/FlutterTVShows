import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/ui/login_register/components/components.dart';

import 'material_app_and_scaffold.dart';

void main() {
  group('Setting hint and label texts', () {
    testWidgets('Set label text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
          ),
        ),
      );

      var textFinder = find.text('Password');

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Set hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
        ),
      );

      var textFinder = find.text('Enter your password');

      expect(textFinder, findsOneWidget);
    });
  });

  group('Text input', () {
    testWidgets('onChanged callback returns correct input value after a single change', (WidgetTester tester) async {
      String inputtedValue = '';

      void onChangedCallback(String value) => inputtedValue = value;

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
            onChanged: onChangedCallback,
          ),
        ),
      );

      await tester.enterText(find.byType(PasswordInputField), 'some_password');
      await tester.pump();

      expect(inputtedValue, 'some_password');
    });

    testWidgets('onChanged callback returns correct input value after multiple changes', (WidgetTester tester) async {
      String inputtedValue = '';

      void onChangedCallback(String value) => inputtedValue = value;

      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
            onChanged: onChangedCallback,
          ),
        ),
      );

      await tester.enterText(find.byType(PasswordInputField), 'some_password');
      await tester.pump();

      await tester.enterText(find.byType(PasswordInputField), 'some_passwords');
      await tester.pump();

      await tester.enterText(find.byType(PasswordInputField), 'some_passwordsss');
      await tester.pump();

      expect(inputtedValue, 'some_passwordsss');
    });

    testWidgets('Text is obscure by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
        ),
      );

      await tester.enterText(find.byType(PasswordInputField), 'some_password');
      await tester.pump();

      final finder = find.byType(TextField);
      final input = tester.firstWidget<TextField>(finder);

      expect(input.obscureText, true);
    });

    testWidgets('Toggle text obscurity by tapping the IconButton once', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
        ),
      );

      await tester.enterText(find.byType(PasswordInputField), 'some_password');
      await tester.pump();

      IconButton iconButton = find.byType(IconButton).evaluate().first.widget as IconButton;
      iconButton.onPressed!();

      await tester.pump();

      final textFieldFinder = find.byType(TextField);
      final input = tester.firstWidget<TextField>(textFieldFinder);

      expect(input.obscureText, false);
    });

    testWidgets('Toggle text obscurity by tapping the IconButton twice', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialAppAndScaffold(
          child: PasswordInputField(
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
        ),
      );

      await tester.enterText(find.byType(PasswordInputField), 'some_password');
      await tester.pump();

      IconButton iconButton = find.byType(IconButton).evaluate().first.widget as IconButton;
      iconButton.onPressed!();
      await tester.pump();

      iconButton.onPressed!();
      await tester.pump();

      final textFieldFinder = find.byType(TextField);
      final input = tester.firstWidget<TextField>(textFieldFinder);

      expect(input.obscureText, true);
    });
  });
}
