import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scroll_controller/product.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_listenToScroolMoments);

    getProduct(page);
  }

  static int page = 0;
  static int x=0;
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
    print("Length of Vehicle");
    print(decodedResponse['data'].length);
    print(decodedResponse['data'][0]['slug']);
    print(decodedResponse['data'][1]['slug']);
     if (response.statusCode == 200) {
      decodedResponse['data'].forEach(
        (e) {
          products.add(Product(
              id: e['id'], slug: e['slug'], brand: e['translate'][0]['title']));
        },
      );
      x=j+1;
    }

    // for (i; i < decodedResponse['data'].length; i++) {
     
    //   products.add(Product(
    //       id: decodedResponse['data'][i]['id'],
    //       slug: decodedResponse['data'][i]['slug'], brand: ''));
    // }
    setState(() {});
     print("here value of i after page ++ $i ");

    print("Thsi is the body length");
    print(decodedResponse.length);

    print("Length of product");

    print(products.length);
    print(products[1].id);
  }


  @override
  List<Product> products = [];
  bool _loadDetailsInProgress = false;
  static int i = 0;

  void getProduct(int page) async {
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
          id: decodedResponse['data'][i]['id'],
          slug: decodedResponse['data'][i]['slug'], brand: ''));
    }
    setState(() {});

    print("Thsi is the body length");
    print(decodedResponse.length);

    print("Length of product");

    print(products.length);
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
        body: ListView.separated(
          controller: _scrollController,
          itemCount: products.length,
          itemBuilder: (BuildContext context, index) {
            return ProductList(index+j);
            
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 4,
            );
          },
        ));
  }

  ListTile ProductList(int x) {
    return ListTile(
            title: Text(products[x].id.toString()),
            subtitle: Text(products[x].slug.toString()),
            
          );
          
  }
  static int j=x;
 
}
