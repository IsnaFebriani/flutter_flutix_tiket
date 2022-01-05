import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_flutix/models/models.dart';
import 'package:flutter_flutix/services/services.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => MovieInitial();
  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      List<Movie> movies = await MovieServices.getMovies(
          1); //ambil page 1, dengan 10(nw playing, 10 coming soon)

      yield MovieLoaded(movies: movies); //jangan lupa yield kan
    }
  }
}
