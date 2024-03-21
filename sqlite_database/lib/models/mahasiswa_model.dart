class MahasiswaModel {
  final int? id;
  final String nim;
  final String nama;
  final String jenjang;
  final String prodi;

  MahasiswaModel({
    this.id,
    required this.nim,
    required this.nama,
    required this.jenjang,
    required this.prodi,
  }); // Constructor

  factory MahasiswaModel.fromMap(Map<String, dynamic> json) => MahasiswaModel(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        jenjang: json["jenjang"],
        prodi: json["prodi"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nim": nim,
        "nama": nama,
        "jenjang": jenjang,
        "prodi": prodi,
      };

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) => MahasiswaModel(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        jenjang: json["jenjang"],
        prodi: json["prodi"],
      );
}
