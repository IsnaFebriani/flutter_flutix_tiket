part of 'models.dart';

class FlutixTransaction extends Equatable {
  final String userID;
  final String title; //judul
  final String subtitle; //subjudul
  final int amount; //jumlah beli
  final DateTime time;
  final String picture; //pat poster film yang dibeli

  FlutixTransaction(
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount = 0, //gawajib di isi, kalo ga isi null
      @required this.time,
      this.picture});

  @override
  List<Object> get props => [userID, title, subtitle, amount, time, picture];
}
