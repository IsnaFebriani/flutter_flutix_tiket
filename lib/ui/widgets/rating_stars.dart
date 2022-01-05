part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize; //ukuran bintang di byk tempat
  final double fontSize; //ukuran size di banyak tmpt

  RatingStars({this.voteAverage = 0, this.starSize = 20, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2)
        .round(); //kan ada 10, makanya dibagi dua dan dibulatkan ke bawah

    List<Widget> widgets = List.generate(
        //lima bintang
        5,
        (index) => Icon(
              index < n
                  ? MdiIcons.star
                  : MdiIcons
                      .starOutline, //bintangnya 5, dan tergantung kalo krg dari 5bintang yang nyala kalo engga pakai outline aja
              color: accentColor2,
              size: starSize,
            ));

    widgets.add(SizedBox(
      width: 3,
    )); //jarak
    widgets.add(Text(
      "$voteAverage/10",
      style: whiteNumberFont.copyWith(
          fontWeight: FontWeight.w300, fontSize: fontSize),
    ));

    return Row(
      children: widgets,
    );
  }
}
