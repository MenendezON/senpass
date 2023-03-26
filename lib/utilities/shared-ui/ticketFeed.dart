import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senpass/models/ticketModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import "package:hovering/hovering.dart";

class TicketFeed extends StatelessWidget {
  final Ticket? ticket;
  final String? userID;
  const TicketFeed({super.key, this.ticket, this.userID});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, top: 20),
            child: Text(formattingDate(ticket!.ticketEntry), style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.black12)
    ),
          child: ListTile(
            leading: const Icon(Icons.add),
            title: Text(
              '${ticket!.ticketProvider}',
              textScaleFactor: 1.5,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${ticket!.ticketType}'),
                Text('${ticket!.ticketNumber} pass'),
              ],
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting('fr', null);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMMEEEEd('fr');
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
