import 'package:flutter/material.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:software_startup/common/CustomStyles.dart';
import 'package:software_startup/controllers/packagescontroller.dart';

class InsuranceView extends StatefulWidget {
  //final InsuranceController controller = InsuranceController();
  InsuranceView({super.key, required this.id});
  final int? id;

  @override
  _InsuranceViewState createState() => _InsuranceViewState();
}

class _InsuranceViewState extends State<InsuranceView> {
  final PackagesController controller = PackagesController(
      baseUrl: 'http://10.0.2.2:8080',
      apiController: ApiController(baseUrl: 'http://10.0.2.2:8080'));

  @override
  Widget build(BuildContext context) {
    Future<DeliveryPackageModel>? package =
        controller.getPackageById(widget.id!);
    Future<double>? shippingPriceFuture =
        controller.getShippingPriceByPackageId(widget.id!);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Verzekeren"),
        ),
        body: Center(
          child: FutureBuilder(
              future: Future.wait([package, shippingPriceFuture]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DeliveryPackageModel packageModel =
                      snapshot.data!.first as DeliveryPackageModel;
                  double shippingPrice = snapshot.data!.last as double;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomStyles.willemRijdtPackageCard(packageModel.id,
                            packageModel.status, packageModel.weight,
                            insuranceInfoText: Text(
                                'Het verzekeren van dit pakket kost: €${shippingPrice / 4}'),
                            //packageDesc: snapshot.data!.description,
                            button: TextButton(
                                onPressed: () => {},
                                child: const Text('Verzekeren')))
                      ]);
                } else if (snapshot.hasError) {
                  return Text(
                      'Error getting data: ${snapshot.error.toString()}');
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}
