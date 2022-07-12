import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    overview,
    posterPath,
    name,
    voteAverage,
    voteCount,
    numberOfEpisodes,
    numberOfSeasons,
  ];
}
