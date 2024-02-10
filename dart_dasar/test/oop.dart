class Manusia {
  String nama;
  int? umur;
  double? berat;

  Manusia({required this.nama, this.umur, this.berat});

  makan(double beratMakan) {
    berat = berat! + beratMakan;
  }

  tidur() {
    berat = berat! - 0.3;
  }
}

void main() {
  var manusia1 = Manusia(nama: "rival", umur: 21, berat: 70)..nama = "ahmad"..umur = 17..berat= 60;
  print("Nama: ${manusia1.nama}");
  print("Umur: ${manusia1.umur}");
  print("Berat: ${manusia1.berat}");

  manusia1.makan(2);
  print("Berat Setelah makan: ${manusia1.berat}");

  manusia1.tidur();
  print("Berat Setelah tidur: ${manusia1.berat}");

  manusia1.nama = "Jono";
  manusia1.umur = 22;

  print("=================SETELAH TIDUR==================");

  print("Nama: ${manusia1.nama}");
  print("Umur: ${manusia1.umur}");
  print("Berat: ${manusia1.berat}");

  // var manusia2 = Manusia(nama: "farrel", umur: 17, berat: 66);
  // print("Nama: ${manusia2.nama}");
  // print("Umur: ${manusia2.umur}");
  // print("Berat: ${manusia2.berat}");
}
