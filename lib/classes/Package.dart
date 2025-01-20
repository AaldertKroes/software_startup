class Package {
  final int id;
  final String name;
  final String description;
  final double packagePrice;
  final int weightGrams; // Gewicht in gram

  late double shippingPrice;
  late String originAddress;
  late String destinationAddress;
  late String status;

  Package(this.id, this.name, this.description, this.packagePrice,
      this.weightGrams);
}

// De backend geeft de status terug als String
//enum Status { NOT_STARTED, UNDERWAY, DELIVERED }
