import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchlistTvs {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
