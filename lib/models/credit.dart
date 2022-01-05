part of 'models.dart';

class Credit extends Equatable {
  final String name; //nm aktor
  final String profilePath; //foto aktor

  Credit({this.name, this.profilePath});

  @override
  List<Object> get props => [name, profilePath];
}
