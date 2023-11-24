import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scroll_controller/class_practice.dart';
import 'package:scroll_controller/item_class.dart';
import 'package:scroll_controller/product.dart';

class DoublVehicle extends StatefulWidget {
  DoublVehicle({super.key});

  @override
  State<DoublVehicle> createState() => _DoublVehicleState();
}

class _DoublVehicleState extends State<DoublVehicle> {
  static String imagePath = "https://pilotbazar.com/storage/vehicles/";

  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_listenToScroolMoments);

    getProduct(page);
  }
    List<Product> products = [];
  List featureUnicTitle = [];
  List featureDetails = [];

  bool _getProductinProgress = false;
  bool _getNewProductinProgress = false;
  static int page = 1;
  static int x = 0;
  void _listenToScroolMoments() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      page++;
      setState(() {});
      getNewProduct(page);

      if (mounted) {
        setState(() {});
      }
    }
  }



  void getNewProduct(int page) async {
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        List<dynamic> vehicleFeatures =
        decodedResponse['data'][0]['vehicle_feature'];
    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      // print('Feature: ${pair.featureTitle}');
      // print('Details: ${pair.detailTitles.join(', ')}');
      featureDetails.add({pair.detailTitles.join(', ')});
      featureUnicTitle.add({pair.featureTitle});
    }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach(
        (e) {
          products.add(Product(
            vehicleName: e['translate'][0]['title'],
            id: e['id'],
            slug: e['slug'],
            manufacture: e['manufacture'],
            condition: e['condition']['translate'][0]['title'],
            mileage: e['mileage']['translate'][0]['title'],
            price: e['price'],
            imageName: e['image']['name'],
          ));
        },
      );
      x = j + 1;
  
      // decodedResponse['data']['vehicle_feature'].forEach((e) {
      //   feature_title.add(e['feature']['title'].toString());
      //   print(feature_title.toString());
      // });
      // for (int a = 0; a < 20; a++) {
      //   feature_title.add(decodedResponse['data']['vehicle_feature'][1]);
      //   if (mounted) {
      //     setState(() {});
      //   }
      //   print(feature_title[a]);
      // }
    }

    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override


  bool _loadDetailsInProgress = false;
  static int i = 0;

  void getProduct(int page) async {
    _getProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        List<dynamic> vehicleFeatures =
        decodedResponse['data'][0]['vehicle_feature'];
    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      // print('Feature: ${pair.featureTitle}');
      // print('Details: ${pair.detailTitles.join(', ')}');
      featureDetails.add({pair.detailTitles.join(', ')});
      featureUnicTitle.add({pair.featureTitle});
    }

    for (i; i < decodedResponse['data'].length; i++) {
      products.add(Product(
        vehicleName: decodedResponse['data'][i]['translate'][0]['title'],
        manufacture: decodedResponse['data'][i]['manufacture'],
        slug: decodedResponse['data'][i]['slug'],
        id: decodedResponse['data'][i]['id'],
        condition: decodedResponse['data'][i]['condition']['translate'][0]
            ['title'],
        mileage: decodedResponse['data'][i]['mileage']['translate'][0]['title'],
        price: decodedResponse['data'][i]['price'],
        imageName: decodedResponse['data'][i]['image']['name'],
      ));
    }
    if (decodedResponse['data'] == null) {
      return;
    }

    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }

    print(products[1].id);
    print("Length of Proucts");
    print(products.length.toString());
  }

  final ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(page.toString()),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //childAspectRatio: 1.0,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 1.0,
          ),
          controller: _scrollController,
          itemCount: products.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Item(
                id: products[index + j].id!,
                imageName: products[index + j].imageName.toString(),
                price: products[index + j].price.toString(),
                featureSeat: featureUnicTitle[index+j].toString(),
                featureSeatDetails: featureDetails[index+j].toString(),
                //dropdownFontLight: products[index+j],
              ),
            );
          },
        ));
  }

  static int j = x;
}
