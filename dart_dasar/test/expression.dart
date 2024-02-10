void main() {
  // niali 0 - 50 => tidak lulus
  // nilai 51 - 75 => bagus
  // nilai 76 - 90 => sangat baik
  // nilai 91 - 100 => perfect
  /*
  int nilai = 150;

  if (nilai >= 0 && nilai <= 50) {
    print("Tidak Lulus");
  } else if (nilai > 50 && nilai <= 75) {
    print("Bagus");
  } else if (nilai > 75 && nilai <= 90) {
    print("Sangat Baik");
  } else if (nilai > 90 && nilai == 100) {
    print("perfect");
  } else {
    print("nilai tidak valid");
  }
  */

  // ==================================== //

  int nilai1 = 67;
  int nilai2 = 90;
  String operator = "+";

  switch (operator) {
    case "+":
    case "-":
      print("${nilai1 + nilai2}");
      print("${nilai1 - nilai2}");
      break;
    default:
      print("Operator tidak valid");
  }
}
