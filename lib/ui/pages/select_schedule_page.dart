part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail; //untuk dipasang dalam tiket

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime; // cek waktu
  Theater selectedTheater; //cek teater
  bool isValid = false; //apa udah pilih tanggal dan pilih waktu?

  @override
  void initState() {
    //menentukan satu minggu
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: accentColor1, //statusbar ungu
            ),
            SafeArea(
                child: Container(
              color: Colors.white, //pagenya putih
            )),
            ListView(
              children: <Widget>[
                // note: BACK BUTTON
                Row(
                  //bungkus button biar di kiri
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                // note: CHOOSE DATE
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  height: 90, // dari tinggi datecard
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(
                                left: (index == 0)
                                    ? defaultMargin
                                    : 0, //default margin untuk index pertama
                                right: (index < dates.length - 1)
                                    ? 16 //dikasih 16
                                    : defaultMargin), //kalo ngga berarti yg plg kanan
                            child: DateCard(
                              dates[index],
                              isSelected:
                                  selectedDate == dates[index], //7 harieun
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          )),
                ),
                //note: CHOOSE TIME
                generateTimeTable(),
                // note: NEXT BUTTON
                SizedBox(
                  height: 10,
                ),
                Align(
                    //button kepage selanjutnya yaituselectseat
                    alignment: Alignment.topCenter,
                    child: BlocBuilder<UserBloc, UserState>(
                      //biar bisa ambil nama user, bungkus dengan blok builder
                      builder: (_, userState) => FloatingActionButton(
                          elevation: 0,
                          backgroundColor: (isValid)
                              ? mainColor
                              : Color(0xFFE4E4E4), //kalo iya ungu kalo ngga abu
                          child: Icon(
                            Icons.arrow_forward,
                            color: isValid
                                ? Colors.white
                                : Color(
                                    0xFFBEBEBE), //kalo iya putih kalo ngga putih
                          ),
                          onPressed: () {
                            if (isValid) {
                              context.bloc<PageBloc>().add(GoToSelectSeatPage(
                                  //bisa pindah asal ada data ini
                                  Ticket(
                                      widget.movieDetail,
                                      selectedTheater,
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      randomAlphaNumeric(12)
                                          .toUpperCase(), //booking coat bernilai random
                                      null, //bangku
                                      (userState as UserLoaded)
                                          .user
                                          .name, //nama
                                      null))); //totalprice
                            }
                          }),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

//bisa catat di firebase atau bisa buat sendiri
  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      //perulangan untuk tiap theater
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(Container(
        //time table
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                //jarak antarcontainer
                left: (index == 0) ? defaultMargin : 0,
                right: (index < schedule.length - 1) ? 16 : defaultMargin),
            child: SelectableBox(
              "${schedule[index]}:00", //nampilin jam
              height: 50,
              isSelected: //true kalo yg dipilih yaitu bioskop saat ini dan jam saat ini
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day !=
                      DateTime.now()
                          .day, //ga bisa milih sebelum waktu skrg, tapi bisa pilih hari besok
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true; //waktunya true
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
