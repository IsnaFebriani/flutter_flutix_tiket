part of 'services.dart';

class FlutixTransactionServices {
  //berupa dua buah services:save dan get
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');
//save
  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.document().setData({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture
    });
  }

//get, mengembalikannya list of transaction
  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();
//query sesuai user id
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userID);
//dimaping jadi flutix transaction nanti jadi list
    return documents
        .map((e) => FlutixTransaction(
            userID: e.data['userID'],
            title: e.data['title'],
            subtitle: e.data['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(e.data['time']),
            amount: e.data['amount'],
            picture: e.data['picture']))
        .toList();
  }
}
