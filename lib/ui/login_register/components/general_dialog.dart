import 'package:flutter/material.dart';

class GeneralDialog extends StatelessWidget {
  const GeneralDialog({Key? key, required this.title, required this.message}) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message.isNotEmpty ? message : 'An unknown error occurred. Please try again.'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodyText1?.copyWith(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
