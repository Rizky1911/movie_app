import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvs();
  }
}
