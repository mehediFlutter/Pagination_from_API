import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
  final String detailsVehicleName;
  final String detailsVehicleManufacture;
  final String detailsVehicleManuConditioin;
  final String detailsVehicleImageName;
   final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? dropdownSeat;
  final String? dropdownSeatAnswer;
  final String? dropdownRoof;
  final String? dropdownRoofAnswer;
  final String? dropdownStarOption;
  final String? dropdownStarOptionAnswer;

  const VehicleDetails(
      {super.key,
      required this.detailsVehicleName,
      required this.detailsVehicleManufacture,
      required this.detailsVehicleManuConditioin,
      required this.detailsVehicleImageName,
      this.dropdownFontLight,
      this.dropdownFontLightAnswer,
      this.dropdownSeat,
      this.dropdownSeatAnswer,
      this.dropdownRoof,
      this.dropdownRoofAnswer,
      this.dropdownStarOption,
      this.dropdownStarOptionAnswer});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.network(widget.detailsVehicleImageName),
            Text(widget.detailsVehicleName),
            Text(widget.detailsVehicleManuConditioin),
            Text(widget.detailsVehicleManufacture)
          ],
        ),
      ),
    );
  }
}
