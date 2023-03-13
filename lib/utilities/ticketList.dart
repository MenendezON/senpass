import 'package:flutter/material.dart';
import 'package:senpass/utilities/data.dart';

class MyListTicket extends StatelessWidget {
  final Resto resto;
  const MyListTicket({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String plat = resto.plate;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Text("list view exemple")
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vous avez fait un bon choix'),
          ),
        );
      },
    );
  }
}
