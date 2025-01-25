class Package {
  final int id;
  final String name;
  final String description;
  final double packagePrice;
  final double weight;

  late double shippingPrice;
  late String originAddress;
  late String destinationAddress;
  late Status status;

  double? latitude;
  double? longitude;

  Package(this.id, this.name, this.description, this.packagePrice, this.weight);
}

// Hoe geeft de backend de enum-waarde terug?
enum Status { NOT_STARTED, UNDERWAY, DELIVERED }
