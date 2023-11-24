import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scroll_controller/class_practice.dart';
import 'package:scroll_controller/double_dehicle.dart';
import 'package:scroll_controller/drawer_item_list.dart';
import 'package:scroll_controller/product.dart';
import 'package:scroll_controller/vehicle_details.dart';

final GlobalKey widgetAKey = GlobalKey();

void main() {
  runApp(Scroll());
}

class Scroll extends StatefulWidget {
  Scroll({super.key});

  @override
  State<Scroll> createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScrollPage());
  }
}

class ScrollPage extends StatefulWidget {
  ScrollPage({super.key});

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
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
    if (mounted) {
      setState(() {});
    }
    print("15 th index");
    print(featureUnicTitle[15]);
    print(featureDetails[15]);

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

    print("Products lentgh");
    print(products.length);
  }

  @override
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
     if (mounted) {
      setState(() {});
    }
    print("This is unic title index");
    print(featureUnicTitle[0]);
    print(featureUnicTitle[1]);

    print(featureUnicTitle);
    print(featureDetails[0].toString());
    print(featureDetails[1].toString());
    print("details of features details");
    print(featureDetails);

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

    // if (decodedResponse['data'] == null) {
    //   return;
    // }

    // show title and details
//      List unitTitles = [];
//  List features = [];
//     decodedResponse['data'].forEach((e) {
//       e['vehicle_feature'].forEach((a) {
//         unitTitles.add(a['feature']['title']);

//         print(a['feature']['title']);
//         print(a['detail']['title']);
//       });
//     });
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
      endDrawer: EndDrawer(mounted: mounted),
      body: ListView.separated(
        controller: _scrollController,
        itemCount: products.length,
        itemBuilder: (BuildContext context, index) {
          return productList(index + j);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 4,
          );
        },
      ),
    );
  }

  productList(int x) {
    return InkWell(
      onTap: () {
        print("Index number is ");
        print(x);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicleDetails(
                      detailsVehicleImageName:
                          "https://pilotbazar.com/storage/vehicles/${products[x].imageName}",
                      detailsVehicleName: products[x].vehicleName.toString(),
                      detailsVehicleManuConditioin:
                          products[x].manufacture.toString(),
                      detailsVehicleManufacture:
                          products[x].manufacture.toString(),
                    )));
      },
      child: ListTile(
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
      ),
    );
  }

  static int j = x;
}

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 230,
        width: 200,
        child: Drawer(
          backgroundColor: Color(0xFF333333),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    DrawerItemList(
                      text: 'DashBoard',
                      icon: Icon(Icons.dashboard),
                      onTapFunction: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MarchentDashBoard()));
                      },
                    ),
                    DrawerItemList(
                      text: 'Item with whats app',
                      icon: Icon(Icons.view_module),
                      onTapFunction: () {
                        // if (mounted) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               HomeWithWhatsAppIcon()));
                        // }
                      },
                    ),
                    DrawerItemList(
                      text: 'View',
                      icon: Icon(Icons.view_agenda_outlined),
                      onTapFunction: () {
                        if (mounted)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoublVehicle()));
                      },
                    ),
                    DrawerItemList(
                      text: 'Logout',
                      icon: Icon(Icons.logout),
                      onTapFunction: () {},
                    ),
                  ],
                ),
              ),
              //ListTile(title: Text("item"),)
            ],
          ),
        ),
      ),
    );
  }
}
