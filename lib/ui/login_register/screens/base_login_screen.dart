import 'package:flutter/material.dart';

import '../components/components.dart';

class BaseLoginScreen extends StatelessWidget {
  const BaseLoginScreen({Key? key, required this.form}) : super(key: key);

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: SingleChildScrollView(
          primary: false,
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const HeaderImage(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 24.0),
                      child: form,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
