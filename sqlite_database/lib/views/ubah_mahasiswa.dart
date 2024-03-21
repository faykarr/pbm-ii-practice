import 'package:flutter/material.dart';
import 'package:sqlite_database/models/database_helper.dart';
import 'package:sqlite_database/models/mahasiswa_model.dart';
import 'home.dart';

class UbahMahasiswa extends StatefulWidget {
  const UbahMahasiswa(
      {super.key,
      this.id,
      required this.nim,
      required this.nama,
      required this.jenjang,
      required this.prodi});

  final int? id;
  final String nim;
  final String nama;
  final String jenjang;
  final String prodi;

  @override
  State<UbahMahasiswa> createState() => _UbahMahasiswaState();
}

class _UbahMahasiswaState extends State<UbahMahasiswa> {
  @override
  void initState() {
    super.initState();
    nimController.text = widget.nim;
    namaController.text = widget.nama;
    jenjangController.text = widget.jenjang;
    prodiController.text = widget.prodi;
  }

  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jenjangController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah Mahasiswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM Mahasiswa',
                ),
              ),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mahasiswa',
                ),
              ),
              TextFormField(
                controller: jenjangController,
                decoration: const InputDecoration(
                  labelText: 'Jenjang Studi Kuliah',
                ),
              ),
              TextFormField(
                controller: prodiController,
                decoration: const InputDecoration(
                  labelText: 'Program Studi',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await DatabaseHelper.instance.updateMahasiswa(
                    MahasiswaModel(
                        id: widget.id,
                        nim: nimController.text,
                        nama: namaController.text,
                        jenjang: jenjangController.text,
                        prodi: prodiController.text),
                  );
                  Navigator.pushAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                      (route) => false);
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan Data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
