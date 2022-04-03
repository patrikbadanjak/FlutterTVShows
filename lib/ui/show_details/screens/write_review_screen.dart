import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/utility/state/consumer_listener.dart';
import 'package:tv_shows/ui/show_details/provider/review_provider.dart';
import 'package:tv_shows/ui/show_details/provider/write_review_provider.dart';

import '../../../source_remote/shows/shows_repository.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final ReviewProvider provider;

  void _showErrorDialog(BuildContext context, Exception exception) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occurred'),
          content: Text('$exception'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
              style: Theme.of(context).textButtonTheme.style?.copyWith(
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                    ),
                  ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WriteReviewProvider>(
      create: (context) => WriteReviewProvider(provider, context.read<ShowsRepository>()),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: ConsumerListener<WriteReviewProvider>(
            listener: (context, provider) {
              provider.state.maybeWhen(
                orElse: () {},
                success: (_) {
                  Navigator.pop(context, true);
                },
                failure: (exception) {
                  _showErrorDialog(context, exception);
                },
              );
            },
            builder: (context, provider) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Write a review',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                    ],
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            minRating: 1,
                            initialRating: provider.rating,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                            ),
                            onRatingUpdate: (rating) => provider.updateRating(rating),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          _TextField(
                            onChanged: (value) => provider.updateComment(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  SafeArea(
                    child: ElevatedButton.icon(
                      icon: provider.state.maybeWhen(
                        orElse: () => Container(),
                        loading: () => const CircularProgressIndicator(),
                      ),
                      label: const Text('Submit'),
                      onPressed: () async {
                        await provider.onSubmitPressed();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      scrollPhysics: const ClampingScrollPhysics(),
      maxLines: null,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Comment',
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
