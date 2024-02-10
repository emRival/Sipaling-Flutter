mixin Berlari {
  lari() {
    print("dia bisa lari");
  }
}

mixin Berjalan {
  lari() {
    print("dia bisaberjalan");
  }
}

// class pada dart biasa di sebut dengan implicit interface
abstract class Hewan {
  String? nama;
  int? umur;
  double? berat;

  Hewan({this.nama, this.umur, this.berat});

  makan(double beratMakanan) {
    berat = berat! + beratMakanan;
  }
}

class Kucing extends Hewan with  Berjalan, Berlari {
  int? kaki;

  Kucing({String? namanya, int? umurnya, double? beratnya, this.kaki})
      : super(nama: namanya, umur: umurnya, berat: beratnya);

  // @override
  // lari() {
  //   print("ini bisa lari class (kucing)");
  // }

  // @override
  // berjalan() {
  //   print("ini bisa berjalan class (kucing)");
  // }

  ngeong() {
    print("ngeeoong...");
  }
}

void main() {
  var kucing1 = Kucing(kaki: 4, namanya: "mona", beratnya: 4, umurnya: 2)
    ..nama = "oyen"
    ..berat = 5;
  // kucing1.nama = "oyenn";
  // kucing1.berat = 5;
  // kucing1.umur = 2;

  // kucing1.makan(1);
  // print("kucing namanya : ${kucing1.nama}");
  // print("kucing umurnya : ${kucing1.umur} Tahun");
  // print("kucing beratnya : ${kucing1.berat} KG");
  // print("kucing memiliki : ${kucing1.kaki} kaki");

  // var hewan1 = Hewan(nama: "abs", umur: 12, berat: 20);
  // print(hewan1.nama);
  kucing1.lari();
  kucing1.lari();
}
