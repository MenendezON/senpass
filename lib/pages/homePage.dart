import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:senpass/models/ticketModel.dart';
import 'package:senpass/services/dbServices.dart';
import 'package:senpass/utilities/data.dart';
import 'package:senpass/utilities/myListContainer.dart';
import 'package:senpass/utilities/myListTransaction.dart';
import 'package:senpass/utilities/shared-ui/showSnackBar.dart';
import 'package:senpass/utilities/showTransfertDialog.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrData = "QR Code";
  int _numberTicket = 0;
  final int _valueTicket = 1000;
  String convertedDateTime = '';
  DateTime now = DateTime.now();

  final oCcy = NumberFormat("#,##0.00 CFA", "en_US");

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;

    // Afficher la date et l'heure
    convertedDateTime = DateFormat('EEEE, d MMM yyyy').format(now);

    // Récupérer la somme des tickets de l'utilisateur
    Stream<List<dynamic>> rlt = DatabaseTicketService(userID: widget.user!.uid).ticketsNumber;
    rlt.listen((ticketList) {
      setState(() {
        _numberTicket = ticketList.fold(0, (previousValue, element) => previousValue + (element as int));
      });
    });

    //------------------------
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      /*drawer: Drawer(
        backgroundColor: Colors.deepOrange,
        child: ListView(
          children: const [
            Text("hello"),
          ],
        ),
      ),*/
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          "assets/images/logo-back.png",
          height: 80,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            tooltip: 'QR Code',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a QR Code')));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => Beamer.of(context).beamToNamed('/profile'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Tooltip(
                  message: 'Votre profile',
                  child: Hero(
                    tag: widget.user!.photoURL!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.user!.photoURL!),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.blueGrey.shade900, Colors.black],
            center: Alignment.center,
            radius: 3,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        padding: const EdgeInsets.only(left: 10, right: 40),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                convertedDateTime,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '$_numberTicket tickets',
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                //'${(_numberTicket * _valueTicket).toStringAsFixed(2)} CFA',
                                '${oCcy.format((_numberTicket * _valueTicket))}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(15),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 170, left: 50, right: 50),
                        decoration: const BoxDecoration(
                            color: Colors.indigo,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.lightBlue,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white,
                                iconSize: 50,
                                onPressed: () => showTicketDialog(
                                    context, widget.user!, _numberTicket),
                              ),
                            ),
                            Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.lightBlue,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.qr_code),
                                color: Colors.white,
                                iconSize: 50,
                                onPressed: () async {
                                  DatabaseTicketService db =
                                      DatabaseTicketService();
                                  Ticket tkt = Ticket(
                                    ticketNumber: 15,
                                    ticketLocate: 'Diamnadio',
                                    ticketProvider: 'Primature Sénégal',
                                    ticketOwner: widget.user!.uid,
                                  );
                                  //String rslt = await db.addTicketDB(tkt);
                                  db.addSubTicket(tkt, "aHkHgARWC0ZnsPbcNBWs");
                                  //print("Le resultat ${rslt}");
                                },
                              ),
                            ),
                            Ink(
                              decoration: const ShapeDecoration(
                                color: Colors.lightBlue,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.history),
                                color: Colors.white,
                                iconSize: 50,
                                onPressed: () =>
                                    Beamer.of(context).beamToNamed('/archive'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    children: const [
                      Text(
                        'Plat du jour',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                  Container(
                      height: 200,
                      decoration: const BoxDecoration(),
                      child: ListView.builder(
                        itemCount: restoList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Resto resto = restoList[index];
                          return MyListContainer(
                            resto: resto,
                          );
                        },
                      )),
                  Gap(20),
                  Row(
                    children: const [
                      Text(
                        'Transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                  Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: 23,

                        itemBuilder: (context, index) {

                          return MyListTransaction();
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTicketDialog(
      BuildContext context, User user, int _numberTicket) async {
    try {
      TransfertDialog(user: user, numberTicket: _numberTicket)
          .showTransfertDialog(context);
    } on SocketException catch (_) {
      showNotification(context, 'Aucune connexion internet');
    }
  }
}
