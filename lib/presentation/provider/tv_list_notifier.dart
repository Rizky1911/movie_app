import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_airing_today_tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTvs = <Tv>[];
  List<Tv> get nowPlayingTvs => _nowPlayingTvs;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getAiringTodayTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetAiringTodayTvs getAiringTodayTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  Future<void> fetchNowPlayingTvs() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvs.execute();
    result.fold(
          (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvs = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
          (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
          (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = moviesData;
        notifyListeners();
      },
    );
  }
}
