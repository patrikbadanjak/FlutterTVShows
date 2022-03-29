import 'package:dio/dio.dart';
import 'package:tv_shows/common/models/review.dart';
import 'package:tv_shows/common/models/show.dart';
import 'package:tv_shows/common/utility/interceptor/auth_info_interceptor.dart';
import 'package:tv_shows/common/utility/interceptor/error_extractor_interceptor.dart';
import 'package:tv_shows/domain/data_holder/auth_info_holder.dart';
import 'package:tv_shows/source_remote/shows/shows_repository.dart';

class ShowsRepositoryImpl implements ShowsRepository {
  ShowsRepositoryImpl(AuthInfoHolder authInfoHolder) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://tv-shows.infinum.academy',
      ),
    );

    final authInfoInterceptor = AuthInfoInterceptor(authInfoHolder);
    final errorExtractorInterceptor = ErrorExtractorInterceptor();

    _dio.interceptors.addAll([
      authInfoInterceptor,
      errorExtractorInterceptor,
    ]);
  }

  late final Dio _dio;

  @override
  Future<List<Show>> getShows() async {
    final response = await _dio.get('/shows');

    final List jsonArray = response.data['shows'];

    return jsonArray.map((show) => Show.fromJson(show)).toList();
  }

  @override
  Future<List<Review>> getReviewsForShow(int showId) async {
    final response = await _dio.get('/shows/$showId/reviews');

    final List jsonArray = response.data['reviews'];

    return jsonArray.map((review) => Review.fromJson(review)).toList();
  }
}
