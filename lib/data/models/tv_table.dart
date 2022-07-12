import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromEntity(TvDetail tvSeriesDetail) =>
      TvTable(
        id: tvSeriesDetail.id,
        name: tvSeriesDetail.name,
        posterPath: tvSeriesDetail.posterPath,
        overview: tvSeriesDetail.overview,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Tv toEntity() => Tv.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    overview: overview,
  );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
