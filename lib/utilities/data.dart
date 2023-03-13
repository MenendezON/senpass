import 'package:firebase_auth/firebase_auth.dart';

class Resto {
  String name;
  String plate;
  int price;
  String phone;
  String image;
  Map<String, int> menu = {'zero': 0, 'one': 1, 'two': 2};

  Resto({
    required this.name,
    required this.plate,
    required this.price,
    required this.phone,
    required this.image,
  });
}

List<Resto> restoList = [
  Resto(
      name: 'Resto 1',
      plate: 'Thiou dien',
      price: 2000,
      phone: '',
      image: 'assets/images/image5.jpg'),
  Resto(
      name: 'Resto 2',
      plate: 'Maffé',
      price: 3000,
      phone: '',
      image: 'assets/images/image2.jpg'),
  Resto(
      name: 'Resto 3',
      plate: 'Thiou guinar',
      price: 2500,
      phone: '',
      image: 'assets/images/image1.jpg'),
  Resto(
      name: 'Resto 4',
      plate: 'Vermicelle',
      price: 2000,
      phone: '',
      image: 'assets/images/image3.jpg'),
  Resto(
      name: 'Resto 5',
      plate: 'Mbaxal saloum',
      price: 3000,
      phone: '',
      image: 'assets/images/image4.jpg'),
  Resto(
      name: 'Four malin',
      plate: 'C\'est bon',
      price: 2500,
      phone: '',
      image: 'assets/images/image6.jpg'),
];

class Ticket {
  User user;
  String resto;
  String proposeby;
  String locate;
  int prixUnit;
  int nbreTicket;

  Ticket({
    required this.user,
    required this.resto,
    required this.proposeby,
    required this.locate,
    required this.prixUnit,
    required this.nbreTicket,
  });
}

List<Ticket> ticketList = [];
