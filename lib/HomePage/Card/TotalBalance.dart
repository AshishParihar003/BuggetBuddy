
import 'package:flutter/material.dart';
import 'package:jar/HomePage/Card/CardOne.dart';

class Totalbalance extends StatelessWidget {
  const Totalbalance({
    super.key,
    required this.data,
  });
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 219, 113, 27),
      child: Column(

        children: [
          const Padding(
  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  child: Text(
    "Total Balance",
    style: TextStyle(
      fontSize: 32, // Adjusted for better proportionality
      fontWeight: FontWeight.bold,
      color: Colors.white, // Ensuring text is readable on darker backgrounds
    ),
  ),
),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  child: Text(
    "\u20B9 ${data['remainingAmount']}", // Using Unicode for the Rupee symbol
    style: TextStyle(
      fontSize: 36, // Slightly reduced for aesthetic balance
      fontWeight: FontWeight.w600, // Bold but less intense than FontWeight.bold
      color: Colors.yellowAccent[700], // A bright color for emphasis
      shadows: const [
        Shadow( // Adding a subtle shadow for a 3D effect
          offset: Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: Color.fromARGB(150, 0, 0, 0),
        ),
      ],
    ),
  ),
),

          Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 10, left: 10, right: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white),
                  child: Row(children: [
                    CardOne(
                      color: const Color.fromARGB(255, 15, 197, 21),
                      heading: 'Credit',
                      amount: "${data['totalCredit']}",
                    ),
                    const SizedBox(width: 10),
                    CardOne(
                      color: const Color.fromARGB(255, 227, 116, 108),
                      heading: 'Debit',
                      amount: "${data['totalDebit']}",
                    )
                  ])),
            ],
          )
        ],
      ),
    );
  }
}
