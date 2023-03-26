import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyListTransaction extends StatelessWidget {
  const MyListTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                        child: Column(
                          children: const [
                            Text('18', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
                            Text('Sat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      child: const Text('Plat de Thiebou dien, au Resto 1, il était ivre à la veille', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(5),
                    child: const Center(child: Text('2,000.00 CFA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                  ),
                ],
              ),
        ),
        const Gap(4)
      ],
    );
  }
}
