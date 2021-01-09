part of 'extensions.dart';

extension FirebaseUserExtensions on FirebaseUser {
  User convertToUser(
          {String name = "No Name",
          List<String> selectedGenres,
          String selectedLanguage = "english",
          int balance}) =>
      User(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
  //pP bisa ada isi ato ngga maka degan optional dihapus
}
