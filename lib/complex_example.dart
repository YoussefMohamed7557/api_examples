import 'dart:convert';
import 'package:api_tutorial/product_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/ComplexModel.dart';

class ComplexExample extends StatefulWidget {
  const ComplexExample({super.key});

  @override
  State<ComplexExample> createState() => _ComplexExampleState();
}

//URL: https://webhook.site/8d788f3e-1112-472e-9f36-8f1414422dcf
class _ComplexExampleState extends State<ComplexExample> {
  List<CardItemData> itemsData = [];
  List<Data> products = [];
  List<String> tempImagesList = [];
  String tempProductName = "";
  String tempShopName = "";
  String tempShopEmail = "";
  String tempProductDescription = "";
  Future<List<Data>> getApiData() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/8d788f3e-1112-472e-9f36-8f1414422dcf'));
    var responseJson = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      ComplexResponse response = ComplexResponse.fromJson(responseJson);
      products = response.data!;
      for (int i = 0; i < products.length; i++) {
        tempProductName = products[i].title!;
        tempProductDescription = products[i].description!;
        tempShopName = products[i].shop!.name.toString();
        tempShopEmail = products[i].shop!.shopemail.toString();
        for (int j = 0; j < products[i].images!.length; j++) {
          tempImagesList.add(products[i].images![j].url!);
        }
        itemsData.add(CardItemData(
            imagesList: tempImagesList,
            productName: tempProductName,
            shopName: tempShopName,
            shopEamil: tempShopEmail,
            productDescription: tempProductDescription));
        tempProductName = "";
        tempProductDescription = "";
        tempShopName = "";
        tempShopEmail = "";
        tempImagesList = [];
      }
      return products;
    } else {
      return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COMPLEX API'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Data>>(
          future: getApiData(),
          builder: (context, snapahot) {
            if (snapahot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapahot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => ProductItem(
                  imagesLink: itemsData[index].imagesList,
                  productName: itemsData[index].productName,
                  shopEmail: itemsData[index].shopEamil,
                  shopName: itemsData[index].shopName,
                  productDescription: itemsData[index].productDescription,
                ),
                itemCount: products.length,
              );
            }
          }),
    );
  }
}

class CardItemData {
  List<String> imagesList;
  String productName;
  String shopName;
  String shopEamil;
  String productDescription;
  CardItemData(
      {required this.imagesList,
      required this.productName,
      required this.shopName,
      required this.shopEamil,
      required this.productDescription});
}
