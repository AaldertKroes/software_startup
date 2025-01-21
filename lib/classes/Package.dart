class Package {
  final int id;
  final int weight; // Gewicht in gram
  final String status;

  late double packagePrice;
  late String description;
  late double shippingPrice;
  late String originAddress;
  late String destinationAddress;
  late String name;

  Package(this.id, this.status, this.weight);
}

// De backend geeft de status terug als String
//enum Status { NOT_STARTED, UNDERWAY, DELIVERED }
