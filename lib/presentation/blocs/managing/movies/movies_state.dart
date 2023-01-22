part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<MovieEntity> movies;

  const MoviesLoadedState({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class MoviesFailureState extends MoviesState {
  final Failure failure;

  const MoviesFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
