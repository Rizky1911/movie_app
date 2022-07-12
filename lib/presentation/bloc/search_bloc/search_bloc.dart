import 'package:ditonton/presentation/bloc/search_bloc/debounce.dart';
import 'package:ditonton/presentation/bloc/search_bloc/search_event.dart';
import 'package:ditonton/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_movies.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
            (failure) {
          emit(SearchError(failure.message));
        },
            (data) {
          emit(SearchHasData(data));
        },
      );
    }
    , transformer: debounce(const Duration(milliseconds: 500)));
  }

}