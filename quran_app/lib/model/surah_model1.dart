import 'dart:convert';

// Fungsi untuk mengurai data JSON menjadi objek Surah
List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

// Fungsi untuk mengonversi objek Surah menjadi format JSON
// String surahToJson(List<Surah> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Kelas untuk merepresentasikan Surah
class Surah {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  TempatTurun tempatTurun;
  String arti;
  String deskripsi;
  String audio;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  // Fungsi untuk mengurai JSON menjadi objek Surah
  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: tempatTurunValues.map[json["tempat_turun"]]!,
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
      );

  // Fungsi untuk mengonversi objek Surah menjadi format JSON
  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}

// Enum untuk menentukan tempat turun Surah
enum TempatTurun { MADINAH, MEKAH }

// Nilai-nilai enum untuk tempat turun Surah
final tempatTurunValues =
    EnumValues({"madinah": TempatTurun.MADINAH, "mekah": TempatTurun.MEKAH});

// Kelas pembantu untuk mengonversi nilai enum menjadi string
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  // Fungsi untuk mengonversi nilai enum menjadi string
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
