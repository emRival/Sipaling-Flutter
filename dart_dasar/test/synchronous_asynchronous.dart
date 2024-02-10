void main() async {
  await getOrder(30).then((status) {
    print("ini adalah status success");
    print(status);
  }).catchError((error) {
    print("ini adalah status failed");
    print(error);
  });

  data1();
 
  data3();
}

data1() {
  print("data 1");
}

data3() {
  print("data 3");
}

data2() {
  Future.delayed(Duration(seconds: 1), () => print("data 2"));
}

Future<String> getOrder(int beli) {
  int stok = 5;

  return Future.delayed(Duration(seconds: 2), () {
    if (stok > beli) {
      return "barang tersedia";
    } else {
      throw "barang tidak cukup";
    }
  });
}
