import 'package:flutter/material.dart';
import 'package:sqlite_database/database_helper.dart';
import 'package:sqlite_database/mahasiswa_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Mahasiswa"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getAllMahasiswa(),
        builder: (BuildContext context,
            AsyncSnapshot<List<MahasiswaModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Loading...'),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Data in the List'),
            );
          } else {
            return ListView(
                children: snapshot.data!
                    .map((data) => Center(
                          child: Card(
                            color: Colors.white70,
                            child: ListTile(
                              title: Text(data.nama),
                            ),
                          ),
                        ))
                    .toList());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
