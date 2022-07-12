import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late TvListNotifier provider;
  late MockGetAiringTodayTvs mockGetAiringTodayTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvs = MockGetAiringTodayTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    provider = TvListNotifier(
      getAiringTodayTvs: mockGetAiringTodayTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTv = Tv(
      backdropPath: "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
      firstAirDate: "2019-07-25",
      genreIds: [
        10765,
        10759
      ],
      id: 76479,
      name: "The Boys",
      originCountry: [
        "US"
      ],
      originalLanguage: "en",
      originalName: "The Boys",
      overview: "A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
      popularity: 4866.719,
      posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
      voteAverage: 8.4,
      voteCount: 6319
  );
  final tTvList = <Tv>[tTv];

  group('now playing tvs', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTvs();
      // assert
      verify(mockGetAiringTodayTvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvs, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvs();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvs data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Right(tTvList));
          // act
          await provider.fetchPopularTvs();
          // assert
          expect(provider.popularTvsState, RequestState.Loaded);
          expect(provider.popularTvs, tTvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvsState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Right(tTvList));
          // act
          await provider.fetchTopRatedTvs();
          // assert
          expect(provider.topRatedTvsState, RequestState.Loaded);
          expect(provider.topRatedTvs, tTvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
