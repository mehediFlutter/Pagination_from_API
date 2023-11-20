import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scroll_controller/product.dart';

class DoublVehicle extends StatefulWidget {
  DoublVehicle({super.key});

  @override
  State<DoublVehicle> createState() => _DoublVehicleState();
}

class _DoublVehicleState extends State<DoublVehicle> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_listenToScroolMoments);

    getProduct(page);
  }

  bool _getProductinProgress = false;
  bool _getNewProductinProgress = false;
  static int page = 0;
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
    _getNewProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    print("Length of Vehicle");
    print(decodedResponse['data'].length);

    print(decodedResponse['data'][0]['slug']);
    print(decodedResponse['data'][1]['slug']);
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
    }

    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  List<Product> products = [];
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
    print("Length of Vehicle");
    print(decodedResponse['data'].length);
    print(decodedResponse['data'][0]['slug']);
    print(decodedResponse['data'][2]['slug']);
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
        body:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 5.0,
                ),
          controller: _scrollController,
          itemCount: products.length,
          itemBuilder: (BuildContext context, index) {
            return productList(index + j);
          },
          // separatorBuilder: (BuildContext context, int index) {
          //   return Divider(
          //     height: 4,
          //   );
          // },
        ));
  }

   productList(int x) {
    return ListTile(
      title: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
            "https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
            // width: 90,
            // height: 100,
            // fit: BoxFit.fill,
            ),
      ),
      //"https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(products[x].vehicleName.toString()),
          SizedBox(height: 10),
          Row(
            children: [
              Text("R:"),
              Text(products[x].manufacture.toString()),
              Text(" | "),

              //Text(products[x].id.toString()),
              Text(products[x].condition.toString()),
              Text(" | "),
              Text(products[x].mileage.toString()),
            ],
          ),
          Text("Available At (PBL)"),
          Row(
            children: [
              Text("Tk."),
              SizedBox(width: 5),
              Text(products[x].price.toString()),
            ],
          ),
        ],
      ),
    );
  }

  static int j = x;
}
