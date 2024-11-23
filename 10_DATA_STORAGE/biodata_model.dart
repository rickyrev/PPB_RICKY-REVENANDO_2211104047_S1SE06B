class Biodata {
  final int? id;
  final String nama;
  final String nim;
  final String alamat;
  final String hobi;

  Biodata({this.id, required this.nama, required this.nim, required this.alamat, required this.hobi});

  // Konversi dari Map ke Object
  factory Biodata.fromMap(Map<String, dynamic> map) {
    return Biodata(
      id: map['id'],
      nama: map['nama'],
      nim: map['nim'],
      alamat: map['alamat'],
      hobi: map['hobi'],
    );
  }

  // Konversi dari Object ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'alamat': alamat,
      'hobi': hobi,
    };
  }
}
