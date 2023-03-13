import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:senpass/services/dbServices.dart';
import 'package:senpass/utilities/data.dart';
import 'package:senpass/utilities/myListContainer.dart';
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
  int _valueTicket = 1000;
  String convertedDateTime = '';
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;

    // Afficher la date et l'heure
    //convertedDateTime = "${now.day.toString().padLeft(2,'0')}/${now.month.toString().padLeft(2,'0')}/${now.year.toString()} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";
    convertedDateTime = DateFormat('EEEE, d MMM yyyy').format(now);

    // Récupérer la somme des tickets de l'utilisateur
    Stream<List<dynamic>> rlt =
        DatabaseTicketService(userID: widget.user!.uid).ticketsNumber;
    rlt.listen((ticketList) {
      setState(() {
        _numberTicket = ticketList.fold(
            0, (previousValue, element) => previousValue + (element as int));
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
          /*IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            tooltip: 'QR Code',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a QR Code')));
            },
          ),*/
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            //const Gap(100),
            Stack(
              alignment: Alignment.center,
              children: [
                /*Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: QrImage(
                      //plce where the QR Image will be shown
                      data: qrData,
                    ),
                  ),
                ),*/
                Container(
                  width: 400,
                  height: 180,
                  margin: EdgeInsets.only(left: 15, right: 15),
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
                          '${convertedDateTime}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${_numberTicket} tickets',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          '${(_numberTicket * _valueTicket).toStringAsFixed(2)} CFA',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(15),
                Container(
                  margin: EdgeInsets.only(top: 170, left: 50, right: 50),
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.transfer_within_a_station),
                          color: Colors.white,
                          iconSize: 50,
                          onPressed: () =>
                              showTicketDialog(context, widget.user!),
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
                          onPressed: () {},
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
            Gap(25),
            Row(
              children: [
                Text(
                  "Plat du jour".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 30,
                )
              ],
            ),
            Container(
              height: 250,
              child: ListView.builder(
                itemCount: restoList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Resto resto = restoList[index];
                  return MyListContainer(
                    resto: resto,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTicketDialog(BuildContext context, User user) async {
    try {
        TransfertDialog(user: user).showTransfertDialog(context);
    } on SocketException catch (_) {
      showNotification(context, 'Aucune connexion internet');
    }
  }
}
