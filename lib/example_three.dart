import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'package:http/http.dart' as http;
class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
List<UsersModel> users = [];
Future<List<UsersModel>> getApiData()async{
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  final data = jsonDecode(response.body.toString());
  if(response.statusCode == 200){
    for(Map i in data){
      users.add(UsersModel.fromJson(i as Map<String,dynamic>));
    }
    return users;
  }else{
    return users;
  }
}
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: SafeArea(
          child: FutureBuilder(future: getApiData(), builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if (snapshot.hasError){
              return Center(child: Text("error!"),);
            }else{
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightGreen,
                  child: Column(children: [
                    ReusableRow("Name", snapshot.data![index].name.toString()),
                    ReusableRow("User Name ", snapshot.data![index].username.toString()),
                    ReusableRow("email", snapshot.data![index].email.toString()),
                    ReusableRow("address street name", snapshot.data![index].address!.street.toString()),
                    ReusableRow("address suite name", snapshot.data![index].address!.suite.toString()),
                    ReusableRow("address city name", snapshot.data![index].address!.city.toString()),
                  ],),
                );
              },);
            }
          },),
        ),
      );
  }
}
class ReusableRow extends StatelessWidget{
  String title;
  String value;
  ReusableRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
          Text(value,style:TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)
        ],),
      );
  }

}
