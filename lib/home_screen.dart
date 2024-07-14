import 'dart:convert';

import 'package:api_tutorial/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> modelList = [];

  Future<List<PostsModel>>? getApiData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      modelList.clear();
      for (Map i in data) {
        modelList.add(PostsModel.fromJson(i as Map<String, dynamic>));
      }
      return modelList;
    } else {
      return modelList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<PostsModel>>(
            future: getApiData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error while loading"));
              } else {
                return ListView.builder(
                    itemCount: modelList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.lightGreen,
                        margin: EdgeInsets.all(8),
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  modelList[index].title ?? "null data",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text("Description",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  modelList[index].body ?? "null data",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
