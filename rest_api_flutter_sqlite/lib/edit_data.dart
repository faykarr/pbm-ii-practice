import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter_sqlite/home.dart';

class EditData extends StatefulWidget {
  const EditData({super.key, required this.list, required this.index});

  final List? list;
  final int index;

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late String idData;
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController prodiController = TextEditingController();

  void editData(String id) {
    var url = Uri.parse(
      'https://6294e329a7203b3ed07364b1.mockapi.io/testapp/mahasiswa/$id',
    );

    http.put(url, body: {
      'nim': nimController.text,
      'nama': namaController.text,
      'prodi': prodiController.text
    });
  }

  void deleteData(String id) {
    var url = Uri.parse(
      'https://6294e329a7203b3ed07364b1.mockapi.io/testapp/mahasiswa/$id',
    );

    http.delete(url, body: {
      'id': widget.list![widget.index]['id'],
    });
  }

  void confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        'Are you sure want to delete ${widget.list![widget.index]['nama']}?',
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            deleteData(idData);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.check_circle),
          label: const Text('Yes, Delete it.'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.cancel),
          label: const Text('Cancel'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  @override
  void initState() {
    idData = widget.list![widget.index]['id'];
    nimController = TextEditingController(
      text: widget.list![widget.index]['nim'],
    );
    namaController = TextEditingController(
      text: widget.list![widget.index]['nama'],
    );
    prodiController = TextEditingController(
      text: widget.list![widget.index]['prodi'],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text("Edit Data - Mahasiswa"),
        centerTitle: true,
        leading: const Icon(Icons.person_search),
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
              'Ubah Data Mahasiswa',
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
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    editData(idData);
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
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    confirmDelete();
                  },
                  icon: const Icon(Icons.person_remove),
                  label: const Text('Hapus Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
