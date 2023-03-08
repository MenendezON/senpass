import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:senpass/data.dart';
import 'package:senpass/myListContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrData = "QR Code";

  @override
  Widget build(BuildContext context) {
    double wScreen = MediaQuery.of(context).size.width;
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
              color: Colors.black,
            ),
            tooltip: 'QR Code',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a QR Code')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  //const Gap(100),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: QrImage(
                        //plce where the QR Image will be shown
                        data: qrData,
                      ),
                    ),
                  ),
                  Gap(25),
                  Row(
                    children: [
                      Text(
                        "Plat du jour".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
