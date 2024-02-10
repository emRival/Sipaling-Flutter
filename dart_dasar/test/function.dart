void main() {
  var hasilnya = pertambahan(2, 3);
  print(hasilnya);

  dynamic bagi = pembagian(3, 6, 7);
  print(bagi);
}

int pertambahan(nilai1, nilai2) {
  int hasil;
  hasil = nilai1 + nilai2;
  return hasil;
}

int pembagian(a, b, [c]) {
  if (c != null) {
    return a / b + c;
  } else {
    return a ~/ b;
  }
}
