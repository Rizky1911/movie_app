import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
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
  final tTvResponseModel =
  TvResponse(tvSeriesList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg",
            "first_air_date": "2019-07-25",
            "genre_ids": [
              10765,
              10759
            ],
            "id": 76479,
            "name": "The Boys",
            "origin_country": [
              "US"
            ],
            "original_language": "en",
            "original_name": "The Boys",
            "overview": "A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
            "popularity": 4866.719,
            "poster_path": "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
            "vote_average": 8.4,
            "vote_count": 6319
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
