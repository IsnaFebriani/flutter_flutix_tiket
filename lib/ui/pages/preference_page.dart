part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = [
    "Bahasa",
    "English",
    "Japanese",
    "Korean",
  ];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = []; //mencatat mana aja yg udah di pilih
  String selectedLanguage = "English"; //defaultnya english

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = ""; //pas diback mau dikosongin lagi

        context.bloc<PageBloc>().add(GoToRegistrationPage(
            widget.registrationData)); //mengembalikan data namadan email
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 56, //supaya arrow backnya ga gantu ganti
                    margin: EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                        onTap: () {
                          widget.registrationData.password = "";

                          context.bloc<PageBloc>().add(
                              GoToRegistrationPage(widget.registrationData));
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Text(
                    "Select Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context), //karena butuh text
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Movie Language\nYou Prefer?",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: mainColor,
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (selectedGenres.length != 4) {
                            //kalo bkn 4 diminta select lain
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Please select 4 genres",
                            )..show(context);
                          } else {
                            widget.registrationData.selectedGenres =
                                selectedGenres;
                            widget.registrationData.selectedLang =
                                selectedLanguage;

                            context.bloc<PageBloc>().add(
                                GoToAccountConfirmationPage(
                                    widget.registrationData));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) /
            2; //perkotak

    return widget.genres //masing masing elemen ada selectebleBox
        .map((e) => SelectableBox(
              e, //elemen dari llist genre
              width: width,
              isSelected:
                  selectedGenres.contains(e), //isSelectednya true kalo dipencet
              onTap: () {
                onSelectGenre(e); //genre yg ditap
              },
            ))
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                //kalo ditap berarti milih onselected genre
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      //kalo udah ada berarti hapus genre
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        //berarti pilih 4
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
