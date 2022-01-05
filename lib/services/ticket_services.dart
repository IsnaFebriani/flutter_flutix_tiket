part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      //collection ama data
      'movieID': ticket.movieDetail.id ?? "",
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  //setvice get ticket
  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents.where((document) =>
        document.data['userID'] ==
        userId); //ambil doc trus query dengan tiket milik si user
//kumpulan tiket yang userid nya sesuai denga user id di kumpulan parameter
    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document
              .data['movieID']); //gapunya movienya, movieIDnya adalah doc
      tickets.add(Ticket(
          movieDetail,
          Theater(document.data['theaterName']), //bentuknya objek teater
          DateTime.fromMillisecondsSinceEpoch(document.data['time']),
          document.data['bookingCode'],
          document.data['seats']
              .toString()
              .split(','), //butuh list of string makanya displit
          document.data['name'],
          document.data['totalPrice']));
    }

    return tickets;
  }
}
