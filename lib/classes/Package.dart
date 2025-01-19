class Package {
  final int id;
  final String name;
  final String description;
  final double packagePrice;
  final int weightGrams; // Gewicht in gram

  late double shippingPrice;
  late String originAddress;
  late String destinationAddress;
  late Status status;

  Package(this.id, this.name, this.description, this.packagePrice,
      this.weightGrams);
}

// Hoe geeft de backend de enum-waarde terug?
enum Status { NOT_STARTED, UNDERWAY, DELIVERED }
