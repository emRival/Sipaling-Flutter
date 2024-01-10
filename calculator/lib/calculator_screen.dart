import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key? key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = "";
  String operator = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false, // to avoid the bottom notch
        child: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1$operator$number2".isEmpty
                        ? "0"
                        : "$number1$operator$number2",
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ), //to make the output scrollable,

            // button
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: value == Btn.n0
                          ? screenSize.width / 2
                          : (screenSize.width / 4),
                      height: screenSize.width / 5,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

//##################################################################################################
  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
                child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ))),
      ),
    );
  }
//##################################################################################################

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.per) {
      converteToPercentage();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void clearAll() {
    number1 = "";
    operator = "";
    number2 = "";
    setState(() {});
  }

  void converteToPercentage() {
    if (number2.isNotEmpty) {
      number2 = (parseFormattedString(number2) / 100).toString();
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (number1.isNotEmpty) {
      number1 = (parseFormattedString(number1) / 100).toString();
    }
    setState(() {});
  }

  void calculate() {
    if (number1.isEmpty || operator.isEmpty || number2.isEmpty) return;
    final n1 = parseFormattedString(number1);
    final n2 = parseFormattedString(number2);
    double result = 0;
    switch (operator) {
      case Btn.add:
        result = n1 + n2;
        break;
      case Btn.subtract:
        result = n1 - n2;
        break;
      case Btn.multiply:
        result = n1 * n2;
        break;
      case Btn.divide:
        result = n1 / n2;
        break;
    }

    number1 = formatNumberWithCommas(result.toString());
    operator = "";
    number2 = "";

    if (number1.endsWith(".0")) {
      number1 = number1.substring(0, number1.length - 2);
    }

    setState(() {});
  }

  double parseFormattedString(String value) {
    var cleanedValue = value.replaceAll(',', ''); // Remove commas
    if (cleanedValue.contains('.') && cleanedValue.endsWith('0')) {
      // Remove trailing zeros after the decimal point
      cleanedValue = cleanedValue
          .replaceAll(RegExp(r"0*$"), "")
          .replaceAll(RegExp(r"\.$"), "");
    }
    return double.parse(cleanedValue);
  }

  //##################################################################################################
  String formatNumberWithCommas(String value) {
    var cleanedValue = value.replaceAll(',', ''); // Remove commas
    final formatter = NumberFormat('#,##0.##', 'en_US');
    return formatter.format(double.parse(cleanedValue));
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if ((number1.isEmpty && number2.isEmpty) ||
          (number1.isEmpty && operator.isEmpty)) {
        return; // Return null when both number1 and number2 are empty
      }
      operator = value;
    } else if (number1.isEmpty || operator.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = "0.";
      }
      number1 += value;
      number1 = formatNumberWithCommas(number1); // Format for display
    } else if (number2.isEmpty || operator.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = "0.";
      }
      number2 += value;
      number2 = formatNumberWithCommas(number2); // Format for display
    }
    setState(() {});
  }

  //##################################################################################################

  Color getButtonColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [Btn.multiply, Btn.divide, Btn.add, Btn.subtract, Btn.calculate]
                .contains(value)
            ? Colors.orange
            : Colors.black;
  }
}
