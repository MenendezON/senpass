import 'package:flutter/material.dart';
import 'package:senpass/utilities/data.dart';

class MyListContainer extends StatelessWidget {
  final Resto resto;
  const MyListContainer({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String plat = resto.plate;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 220,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(resto.image),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resto.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    '${resto.plate} : ${resto.price.toStringAsFixed(2)} CFA',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
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
