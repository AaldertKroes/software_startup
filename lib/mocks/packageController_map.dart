import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesController {
  List<DeliveryPackageModel> getPackages() {
    // Hier zou je normaal gesproken data ophalen van een API
    return [
      DeliveryPackageModel(
          packageSize: "10x34x23",
          weight: 1500,
          distance: 596,
          status: "NOT_STARTED",
          startLocationId: 1,
          endLocationId: 2,
          senderId: 3,
          receiverId: 4),
      DeliveryPackageModel(
          packageSize: "20x20x20",
          weight: 2000,
          distance: 120,
          status: "IN_TRANSIT",
          startLocationId: 2,
          endLocationId: 3,
          senderId: 1,
          receiverId: 2),
      DeliveryPackageModel(
          packageSize: "15x15x30",
          weight: 3000,
          distance: 300,
          status: "DELIVERED",
          startLocationId: 3,
          endLocationId: 4,
          senderId: 2,
          receiverId: 3),
      DeliveryPackageModel(
          packageSize: "50x50x50",
          weight: 10000,
          distance: 1500,
          status: "NOT_STARTED",
          startLocationId: 4,
          endLocationId: 1,
          senderId: 3,
          receiverId: 4),
      DeliveryPackageModel(
          packageSize: "40x30x20",
          weight: 5000,
          distance: 750,
          status: "IN_TRANSIT",
          startLocationId: 5,
          endLocationId: 6,
          senderId: 4,
          receiverId: 5),
      DeliveryPackageModel(
          packageSize: "25x25x25",
          weight: 2500,
          distance: 600,
          status: "DELIVERED",
          startLocationId: 6,
          endLocationId: 7,
          senderId: 5,
          receiverId: 6),
      // Voeg meer pakketten toe
    ];
  }
}
