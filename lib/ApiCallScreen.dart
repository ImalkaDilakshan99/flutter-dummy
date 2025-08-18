import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Apicallscreen extends StatefulWidget {
  const Apicallscreen({super.key});

  @override
  State<Apicallscreen> createState() => _ApicallscreenState();
}

class _ApicallscreenState extends State<Apicallscreen> {
  int age = 0;
  bool isLoading = false;
  final TextEditingController name = TextEditingController();

  void getData() async {
    setState(() {
    isLoading = true;
  });

    var url = Uri.parse("https://api.agify.io/?name=${name.text}");
    Response rs = await get(url);
    Map urs = jsonDecode(rs.body);
    isLoading = true;

    setState(() {
      age = urs['age'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getData();
        },
        child: Icon(Icons.api),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Get API Data"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Name",
                ),
              ),
              SizedBox(height: 60),
              if (!isLoading)
                Text(
                  "Your age is: $age",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                )
              else
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
