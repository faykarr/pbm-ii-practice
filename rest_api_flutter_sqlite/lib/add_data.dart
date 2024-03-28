import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter_sqlite/home.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController prodiController = TextEditingController();

  void addData() {
    var url = Uri.parse(
      'https://6294e329a7203b3ed07364b1.mockapi.io/testapp/mahasiswa',
    );

    http.post(url, body: {
      'nim': nimController.text,
      'nama': namaController.text,
      'prodi': prodiController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text("Tambah Data - Mahasiswa"),
        centerTitle: true,
        leading: const Icon(Icons.person_add),
        backgroundColor: Colors.indigo[100],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 40.0,
          bottom: 15.0,
        ),
        child: ListView(
          children: [
            Text(
              'Input Data Mahasiswa',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nimController,
              decoration: InputDecoration(
                labelText: 'Nomor Induk Mahasiswa (NIM)',
                icon: const Icon(Icons.co_present_rounded),
                iconColor: Colors.grey.shade700,
                labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                icon: const Icon(Icons.person),
                iconColor: Colors.grey.shade700,
                labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: prodiController,
              decoration: InputDecoration(
                labelText: 'Program Studi',
                icon: const Icon(Icons.home_repair_service_rounded),
                iconColor: Colors.grey.shade700,
                labelStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton.icon(
              onPressed: () {
                addData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Simpan Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
