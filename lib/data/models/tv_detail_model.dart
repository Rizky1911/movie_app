import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';
import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
  });

  final bool adult;
  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons
  };

  TvDetail toEntity() {
    return TvDetail(
        adult: this.adult,
        backdropPath: this.backdropPath,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons
    );
  }

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    name,
    overview,
    posterPath,
    voteAverage,
    voteCount,
    numberOfEpisodes,
    numberOfSeasons,
  ];
}
