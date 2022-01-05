part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width; //lbar
  final bool isSelected; //saat diselect apa ngga
  final int amount; //
  final Function onTap; //kalau ditap mauapa

  MoneyCard(
      {this.isSelected = false, this.amount = 0, this.onTap, this.width = 90});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //ngebungkus container
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: isSelected ? Colors.transparent : Color(0xFFE4E4E4)),
            color: isSelected ? accentColor2 : Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "IDR",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              //spy ada titiknya di matauang
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: '')
                  .format(amount),
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
