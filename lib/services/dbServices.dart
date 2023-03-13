import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:senpass/models/ticketModel.dart';

class DatabaseTicketService {
  String? userID;
  DatabaseTicketService({required this.userID});

  // Déclaraction et Initialisation
  CollectionReference _tickets = FirebaseFirestore.instance.collection('tickets');

  // suppression de la voiture
  Future<void> deleteTicket(String ticketID) => _tickets.doc(ticketID).delete();

  // Récuperation de toutes les voitures en temps réel
  Stream<List<Ticket>> get tickets {
    Query queryTickets = _tickets.where('ticketOwner', isEqualTo: userID).orderBy('ticketEntry', descending: true);
    return queryTickets.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Ticket(
          ticketID: doc.id,
          ticketLocate: doc.get('ticketLocate'),
          ticketNumber: doc.get('ticketNumber'),
          ticketOwner: doc.get('ticketOwner'),
          ticketProvider: doc.get('ticketProvider'),
          ticketRepas: doc.get('ticketRepas'),
          ticketType: doc.get('ticketType'),
          ticketEntry: doc.get('ticketEntry'),
        );
      }).toList();
    });
  }


  /*Stream<int> get fetchNbrTickets {
    int nberTicket = 0;
    return _tickets.doc(userID).snapshots().map((doc) {
      nberTicket += doc.get('ticketNumber') as int;
    });
  }*/

  Stream<List<dynamic>> get ticketsNumber {
    Query queryTickets = _tickets.where('ticketOwner', isEqualTo: userID).orderBy('ticketEntry', descending: true);
    return queryTickets.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.get('ticketNumber');
      }).toList();
    });
  }

  Future<int?> getTicketNumber() async {
    // Get a reference to the document
    DocumentReference documentReference = _tickets.doc();

    // Get the document snapshot
    DocumentSnapshot documentSnapshot = await documentReference.get();

    // Check if the document exists and has the ticketNumber field
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      // Get the ticketNumber value
      dynamic data = documentSnapshot.data();
      int? ticketNumber = (data as Map<String, dynamic>)['ticketNumber'];
      return ticketNumber;
    } else {
      return null;
    }
  }


  Future<Ticket> singleCar(String ticketID) async {
    final doc = await _tickets.doc(ticketID).get();
    return Ticket(
      ticketID: ticketID,
      ticketLocate: doc.get('ticketLocate'),
      ticketNumber: doc.get('ticketNumber'),
      ticketOwner: doc.get('ticketOwner'),
      ticketProvider: doc.get('ticketProvider'),
      ticketRepas: doc.get('ticketRepas'),
      ticketType: doc.get('ticketType'),
      ticketEntry: doc.get('ticketEntry'),
    );
  }
}