part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController =
      TextEditingController(text: 'IDR 0'); //controller buat ngetik uang
  int selectedAmount = 0; //bukan temp tapi hrs integer

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(//supaya ttp aby, prymery colornya ke abu
        ChangeTheme(ThemeData().copyWith(primaryColor: Color(0xFFE4E4E4))));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) /
            3; //space untuk 3 buah kartu

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);

        return;
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                // note: BACK ARROW
                SafeArea(
                    child: Container(
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  child: GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(widget.pageEvent);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black)),
                )),
                // note: CONTENT
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Top Up",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (text) {
                          String temp = '';

                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i)
                                ? text[i]
                                : ''; //kalau merpakan angka, maka akan ditambahkan ke temp kalau ngga akan dibeti string kosong
                          }

                          setState(() {
                            selectedAmount = int.tryParse(temp) ??
                                0; //string tem di ubah dulu ke integer
                          });

                          amountController.text = NumberFormat.currency(
                                  //untuk ditambahkan dalam currency
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0)
                              .format(selectedAmount);

                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  //kursor akan dipindahkan ke paling akhir
                                  offset: amountController.text.length));
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelStyle: greyTextFont,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Amount",
                        ),
                      ),
                      Align(
                        //supaya rata kiri, ga di center
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 14),
                          child:
                              Text("Choose by Template", style: blackTextFont),
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 14,
                        children: <Widget>[
                          makeMoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 100000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 150000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 200000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 250000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 1000000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 2500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 5000000,
                            width: cardWidth,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        //tombol
                        width: 250,
                        height: 46,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Top Up My Wallet",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (selectedAmount > 0)
                                        ? Colors.white
                                        : Color(0xFFBEBEBE)),
                              ),
                              disabledColor: Color(0xFFE4E4E4),
                              color: Color(0xFF3E9D9D),
                              onPressed: (selectedAmount >
                                      0) //harus ada yg aktif
                                  ? () {
                                      context.bloc<PageBloc>().add(
                                          GoToSuccessPage(
                                              null, //ticket
                                              FlutixTransaction(
                                                  //fluttertransaction
                                                  userID:
                                                      (userState as UserLoaded)
                                                          .user
                                                          .id, //butuh user id
                                                  title: "Top Up Wallet",
                                                  amount: selectedAmount,
                                                  subtitle:
                                                      "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}", //dari extension
                                                  time: DateTime.now())));
                                    }
                                  : null), //kalo gada yg aktif 0
                        ),
                      ),
                      SizedBox(
                        height: 100, //supy ga mepet
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//fungsi dlm moneycard
  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount != amount) {
            //kalau selectedamaunt tdk sama dengan emount, maka dipilih
            selectedAmount = amount; //kalau udah ada, maka di unselect
          } else {
            selectedAmount = 0;
          }

          amountController.text = NumberFormat.currency(
                  //textnya pake format currecy
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: 'IDR ')
              .format(selectedAmount);

          amountController.selection = TextSelection.fromPosition(TextPosition(
              offset: amountController.text.length)); //kursor dipindah ke blkg
        });
      },
    );
  }
}
