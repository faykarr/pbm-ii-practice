import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'mahasiswa_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // ignore: unused_field
  static late Database _database;
  Future<Database> get database async => _database = await _initDatabase();

  // Initial Database config path & database name
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mahasiswa.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Initial function query SQL for create table
  Future _onCreate(Database db, int version) async {
    String sql =
        'CREATE TABLE mahasiswa(id INTEGER PRIMARY KEY, nama TEXT, jenjang TEXT, prodi TEXT)';
    await db.execute(sql);
  }

  // Query SQL function to getAllMahasiswa
  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    Database db = await instance.database;
    var result = await db.query('mahasiswa', orderBy: 'nama');
    List<MahasiswaModel> mahasiswaList = result.isNotEmpty
        ? result.map((e) => MahasiswaModel.fromMap(e)).toList()
        : [];
    return mahasiswaList;
  }

  // Query SQL Function to getMahasiswaById
  Future<List<MahasiswaModel>> getMahasiswaById(int id) async {
    List<MahasiswaModel> mahasiswaList;
    Database db = await instance.database;
    var result = await db.query('mahasiswa', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      mahasiswaList = result.map((e) => MahasiswaModel.fromMap(e)).toList();
    } else {
      mahasiswaList = [];
    }
    return mahasiswaList;
  }

  // Query SQL Function to insert new mahasiswa Data
  Future<int> addMahasiswa(MahasiswaModel mahasiswaModel) async {
    Database db = await instance.database;
    var result = await db.insert('mahasiswa', mahasiswaModel.toMap());
    return result;
  }

  // Query SQL Function to update mahasiswa Data
  Future<int> updateMahasiswa(MahasiswaModel mahasiswaModel) async {
    Database db = await instance.database;
    var result = db.update('mahasiswa', mahasiswaModel.toMap(),
        where: 'id = ?', whereArgs: [mahasiswaModel.id]);
    return result;
  }

  // Query SQL Function to delete a mahasiswa Data
  Future<int> deleteMahasiswa(int id) async {
    Database db = await instance.database;
    var result = db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
