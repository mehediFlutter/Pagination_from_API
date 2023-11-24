import 'dart:convert';

import 'package:http/http.dart';

class FeatureDetailPair {
  final String featureTitle;
  final List<String> detailTitles;

  FeatureDetailPair(this.featureTitle, this.detailTitles);
}

List<FeatureDetailPair> extractFeatureDetails(List<dynamic> vehicleFeatures) {
  Map<String, List<String>> featureDetailsMap = {};

  for (var feature in vehicleFeatures) {
    String featureTitle = feature['feature']['title'];
    String detailTitle = feature['detail']['title'];

    if (!featureDetailsMap.containsKey(featureTitle)) {
      featureDetailsMap[featureTitle] = [];
    }

    // Add the detail title only if it's not already present
    if (!featureDetailsMap[featureTitle]!.contains(detailTitle)) {
      featureDetailsMap[featureTitle]?.add(detailTitle);
    }
  }

  // Convert the map to a list of FeatureDetailPair objects
  List<FeatureDetailPair> result = featureDetailsMap.entries
      .map((entry) => FeatureDetailPair(entry.key, entry.value))
      .toList();

  return result;
}

// Future<void> main() async {
//   // Assuming decodedResponse['data'][i]['vehicle_feature'] is your vehicle features data
  
//    Response response =
//         await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=1"));
//     //https://pilotbazar.com/api/vehicle?page=0
//     //https://crud.teamrabbil.com/api/v1/ReadProduct
//     print(response.statusCode);
//     final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
//   List<dynamic> vehicleFeatures = decodedResponse['data'][0]['vehicle_feature'];

//   List<FeatureDetailPair> featureDetailPairs = extractFeatureDetails(vehicleFeatures);
// List details=[];
// List tittt=[];
//   // Now featureDetailPairs contains the desired information
//   for (var pair in featureDetailPairs) {
//     print('Feature: ${pair.featureTitle}');
//     tittt.add({pair.featureTitle});
//     print('Details: ${pair.detailTitles.join(', ')}');
//     details.add({pair.detailTitles.join(', ')});
//     print('-----');
//   }
//   print(vehicleFeatures);
//   print(featureDetailPairs);
//   print("This is Details");
//   print(details);
//   print("Index show ");
//   print(details[0].toString());
//   print(details[1].toString());
//   print("Unic title");
//   print(tittt);
// }
