import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider_listener.dart';

class ConsumerListener<Notifier extends ChangeNotifier> extends StatelessWidget {
  const ConsumerListener({Key? key, required this.listener, required this.builder}) : super(key: key);

  final void Function(BuildContext context, Notifier provider) listener;
  final Widget Function(BuildContext context, Notifier provider) builder;

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      listener: listener,
      child: Consumer<Notifier>(
        builder: (context, provider, _) => builder(context, provider),
      ),
    );
  }
}
