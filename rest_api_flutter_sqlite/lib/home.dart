import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter_sqlite/add_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse(
          "https://6294e329a7203b3ed07364b1.mockapi.io/testapp/mahasiswa"),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text("Data Mahasiswa - Mock API"),
        centerTitle: true,
        leading: const Icon(Icons.people_alt),
        backgroundColor: Colors.indigo[100],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddData(),
            ),
          );
        },
        label: const Text("Tambah Data"),
        icon: const Icon(Icons.person_add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ItemList(list: snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 3,
            right: 3,
          ),
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(list[index]['nama']),
                leading: const Icon(Icons.person),
                subtitle: Text("${list[index]['nim']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
