part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage; //rating
  final String overview; //deskrpsi
  final String posterPath; //pathgambar poster
  final String backdropPath; //path gambar bg

  Movie(
      //dijadikan optional semua, diisi dengan req
      {@required this.id, //req butuh material .dart
      @required this.title,
      @required this.voteAverage,
      @required this.overview,
      @required this.posterPath,
      @required this.backdropPath});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num)
          .toDouble(), //hasil vote itu double tapi kadang kembaliannya integer jadi ngaco makanya butuh itu
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path']);

  @override
  List<Object> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
