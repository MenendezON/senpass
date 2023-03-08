class Resto {
  String name;
  String plate;
  int price;
  String image;

  Resto({
    required this.name,
    required this.plate,
    required this.price,
    required this.image,
  });
}

List<Resto> restoList = [
  Resto(name: 'Resto 1', plate: 'Thiou dien', price: 2000, image: 'assets/images/image5.jpg'),
  Resto(name: 'Resto 2', plate: 'Maffé', price: 2000, image: 'assets/images/image2.jpg'),
  Resto(name: 'Resto 3', plate: 'Thiou guinar', price: 2000, image: 'assets/images/image1.jpg'),
  Resto(name: 'Resto 4', plate: 'Vermicelle', price: 2000, image: 'assets/images/image3.jpg'),
  Resto(name: 'Resto 5', plate: 'Mbaxal saloum', price: 2000, image: 'assets/images/image4.jpg'),
];