part of 'widgets.dart';

class DateCard extends StatelessWidget {
  //field
  final bool isSelected; //sdg dipilih ngga?
  final double width;
  final double height;
  final DateTime date; //tgl yg mo ditampilkan
  final Function
      onTap; //mengimpan method yg akan dijalankan saat date card di tap

  DateCard(this.date,
      {this.isSelected = false, this.width = 70, this.height = 90, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          //kalo ga null ya dijalanin bloknya
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected
                ? accentColor2
                : Colors
                    .transparent, //kalo true bakal oren, kalo ngga bakal transparan
            border: Border.all(
                color: isSelected ? Colors.transparent : Color(0xFFE4E4E4))),
        child: Column(
          //berisi hari dan tanggal
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              date.day.toString(),
              style: whiteNumberFont.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
