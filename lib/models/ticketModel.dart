import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  String? ticketID, ticketLocate, ticketOwner, ticketProvider, ticketType;
  int? ticketNumber, ticketRepas;
  Timestamp? ticketEntry;

  Ticket({
    this.ticketID,
    this.ticketLocate,
    this.ticketOwner,
    this.ticketProvider,
    this.ticketType,
    this.ticketNumber,
    this.ticketRepas,
    this.ticketEntry,
  });
}
