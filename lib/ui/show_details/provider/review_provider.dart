import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';

import '../../../common/models/review.dart';
import '../../../common/models/show.dart';

class ReviewProvider extends ChangeNotifier {
  ReviewProvider(this._repository, {required this.show});

  final ShowsRepository _repository;
  final Show show;

  String errorMessage = '';

  List<Review> _reviews = List<Review>.empty();

  Future<void> fetchReviews() async {
    _reviews = await _getReviewsForShow();
    notifyListeners();
  }

  Future<List<Review>> get reviews async {
    if (_reviews.isNotEmpty) {
      return _reviews;
    } else {
      await fetchReviews();
    }

    return _reviews;
  }

  Future<List<Review>> _getReviewsForShow() async {
    try {
      return await _repository.getReviewsForShow(show.id);
    } on Exception catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
    return List<Review>.empty();
  }
}
