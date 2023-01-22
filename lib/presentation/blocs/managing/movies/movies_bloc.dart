import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/domain/entities/movie_entity.dart';
import 'package:minapharm_task/domain/usecases/get_movies_use_case.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  GetMoviesUseCase getMoviesUseCase;

  MoviesBloc({required this.getMoviesUseCase}) : super(MoviesInitial()) {
    on<MoviesGetRecentMoviesEvent>(_onGetMoviesEvent);
  }

  _onGetMoviesEvent(MoviesGetRecentMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoadingState());
    (await getMoviesUseCase(null)).fold(
      (failure) => emit(MoviesFailureState(failure: failure)),
      (movies) => emit(MoviesLoadedState(movies: movies)),
    );
  }
}
