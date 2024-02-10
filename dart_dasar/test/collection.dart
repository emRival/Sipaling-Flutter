void main() {
  /*
  List hewan = ["kucing", "burung", "monyet"];
  print(hewan);
  hewan.insert(2, "singa");
  print(hewan);
  hewan.insert(4, "curut");
  print(hewan);
  hewan.add("kukang");
  print(hewan);
  hewan.addAll(["semut", "kecoa", "lintah"]);
  print(hewan);
  hewan.insertAll(2, ["gajah", "jerapah", "jerapah", "kudanil"]);
  print(hewan);
  hewan.remove("jerapah");
  print(hewan);
  hewan.removeRange(1, 11);
  print(hewan);
  hewan.removeAt(0);
  print(hewan);
  */

  // ======================================== //

  // List<String> rpl = ["farrel", "younes", "rakha"];
  // List<String> tkj = ["opang", "kegan", "aghnat"];

  // var gabungan = rpl + tkj;
  // print(gabungan);

  // SET =====================>
  // Set name = {"faizul", "nadhif", "awan"};
  // Set name2 = {"aisy", "fahmi", "tb", "faizul"};

  // var merge = name.union(name2);
  // var cariyangsama = name.intersection(name2);
  // print(name.elementAt(1));
  // print(merge);
  // print(cariyangsama);

  // MAP =====================>
  var data = {"nama": "farrel", "umur": 17, "jurusan": "RPL"};
  data["pekerjaan"] = "pelajar";
  data.addEntries({"makanan": "yfytdft"}.entries);
  data.addAll({"alamat": "lampung"});

  print("${data["nama"]} ${data["jurusan"]}");
  print(data);
}
