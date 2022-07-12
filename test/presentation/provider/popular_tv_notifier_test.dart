import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvs = MockGetPopularTvs();
    notifier = PopularTvsNotifier(mockGetPopularTvs)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
