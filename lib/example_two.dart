import 'dart:convert';

import 'package:api_tutorial/models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<PhotosModel> modelList = [];
  Future<List<PhotosModel>>getApiData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      modelList.clear();
      for (Map i in data){
        modelList.add(PhotosModel.fromJson(i as Map<String,dynamic>));
      }
      return modelList;
    }else{
      return modelList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('task 2 API'),),
      body: FutureBuilder<List<PhotosModel>>(
        future: getApiData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text('error'));
          }
          else{
            return ListView.builder(
              itemCount:modelList.length,
              itemBuilder: (context, index) {
                return ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
                  title: Text(snapshot.data![index].title.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                subtitle: Text(snapshot.data![index].title.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300)),);
              },);
          }
        },
      ),
    );
  }
}
