import 'package:flutter/material.dart';
import 'home.dart';
import '../models/mahasiswa_model.dart';
import '../models/database_helper.dart';

class InputMahasiswa extends StatefulWidget {
  const InputMahasiswa({super.key});

  @override
  State<InputMahasiswa> createState() => _InputMahasiswaState();
}

class _InputMahasiswaState extends State<InputMahasiswa> {
  int? selectedId;
  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jenjangController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Mahasiswa"),
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
                  await DatabaseHelper.instance.addMahasiswa(MahasiswaModel(
                    nim: nimController.text,
                    nama: namaController.text,
                    jenjang: jenjangController.text,
                    prodi: prodiController.text,
                  ));
                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan Data'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
