part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      //di luar app
      //return SignInPage();
      //diganti
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      //return MainPage();
      if (!(prevPageEvent is GoToSplashPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(GoToMainPage());
      }
    }
    //<dari, kembalian>
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnPreferencePage)
                        ? PreferencePage(pageState.registrationData)
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(
                                pageState.registrationData)
                            : MainPage());
  }
}
