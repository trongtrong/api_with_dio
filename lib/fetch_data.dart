import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_api2/photo.dart';

class FetchData extends StatefulWidget {
  @override
  FetchDataState createState() => FetchDataState();
}

class FetchDataState extends State<FetchData> {
  List<Photo> list = [];
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('This is test api with Dio'),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text(
            'Fetch Data',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: _fetchData,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(
                    list[index].thumbnailUrl,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                  title: Text(list[index].title),
                );
              }),
    );
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var dio = Dio();
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode == 200) {
      print('Succes');
      list = (json.decode(response.data) as List)
          .map((data) => Photo.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      print('Error network');
    }
  }
}
