import 'package:flutter/material.dart';
import 'package:sqlite_database/models/database_helper.dart';
import 'package:sqlite_database/models/mahasiswa_model.dart';
import 'package:sqlite_database/views/ubah_mahasiswa.dart';
import 'package:sqlite_database/views/input_mahasiswa.dart';

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
        title: const Text(
          "Daftar Mahasiswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                            onTap: () {
                              setState(
                                () {
                                  if (selectedId == null) {
                                    selectedId = data.id;
                                  } else {
                                    selectedId = null;
                                  }
                                },
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (UbahMahasiswa(
                                    id: data.id,
                                    nim: data.nim,
                                    nama: data.nama,
                                    jenjang: data.jenjang,
                                    prodi: data.prodi,
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputMahasiswa()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Data'),
      ),
    );
  }
}
