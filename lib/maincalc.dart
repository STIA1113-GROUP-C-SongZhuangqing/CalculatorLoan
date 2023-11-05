import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class MainCalc extends StatefulWidget {
  const MainCalc({super.key});

  @override
  State<MainCalc> createState() => _MainCalcState();
}

class _MainCalcState extends State<MainCalc> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  double amount = 0, term = 0, rate = 0, month = 0, totalInterest = 0, totalPayment = 0;
  bool showResults = false;
  final player = AudioPlayer();

  Widget buildInputRow(String labelText, TextEditingController controller, {String? suffixText}) {
  return Row(
    children: [
      Text(
        labelText,
        style: const TextStyle(
          fontSize:20   // 设置文本部分的宽度
        ),
      ),
      Expanded(
        child :SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $labelText',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixText: suffixText,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        ),
      )
      ),
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Calculator")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
    buildInputRow("Loan Amount: ", textEditingController1),
    const SizedBox(height: 8),
    buildInputRow("Loan Term:      ", textEditingController2, suffixText: 'years'),
    const SizedBox(height: 8),
    buildInputRow("Interest Rates:", textEditingController3, suffixText: '%'),
    const SizedBox(height: 8),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonTheme(
          minWidth: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: Calculator,
            child: const Text(
              "Calculate",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        ButtonTheme(
          minWidth: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: Clear,
            child: const Text(
              "Clear",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // 设置交叉轴对齐方式为左对齐
              children: [
              const SizedBox(height: 10),
              if (showResults) Text('Monthly Payment: ${month.toStringAsFixed(2)}'),
              const SizedBox(height: 4),
              if (showResults) Text('You will need to pay ${month.toStringAsFixed(2)} every month for $term years to payoff the debt.'),
              const SizedBox(height: 4),
              if (showResults) Text('Total Payment: ${totalPayment.toStringAsFixed(2)}'),
              const SizedBox(height: 4),
              if (showResults) Text('Total Interest: ${totalInterest.toStringAsFixed(2)}'),
              const SizedBox(height: 4),
            ],
)
          ]),
        ),
      ),
    ),
    );
  }

  // ignore: non_constant_identifier_names
  void Calculator() {
      amount = double.tryParse(textEditingController1.text) ?? 0;
      term = double.tryParse(textEditingController2.text) ?? 0;
      rate = double.tryParse(textEditingController3.text) ?? 0;
      totalInterest = amount * term * rate;
      totalPayment = totalInterest + amount;
      month = totalPayment/(term*12);
      setState(() {
      showResults = true;
      });
  }

  // ignore: non_constant_identifier_names
  void Clear() {
    setState(() {
    textEditingController1.clear();
    textEditingController2.clear();
    textEditingController3.clear();
                }
    );
  }
}