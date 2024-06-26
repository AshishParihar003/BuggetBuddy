
import 'package:flutter/material.dart';

class CardOne extends StatelessWidget {
  const CardOne(
      {super.key,
      required this.color,
      required this.heading,
      required this.amount});

  final Color color;
  final String heading;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12), // Rounded corners
          border: Border.all(
              color: const Color.fromARGB(0, 104, 58, 183),
              width: 1), // Adds border
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // Shadow color
              blurRadius: 6,
              offset: Offset(0, 3), // Position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                // Making the first column take up all available space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Align items to center vertically
                  children: [
                    Text(
                      heading,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 18, 8, 36),
                          fontSize:
                              30, // Adjusted for better fit and aesthetics
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹ ${amount}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 12, 120),
                          fontSize: 28, // Adjusted for consistency
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Icon(
                heading == "Credit"
                    ? Icons.arrow_upward_outlined
                    : Icons.arrow_downward_outlined,
                color: Colors.black,
                size: 35, // Adjusted size for better visibility
              )
            ],
          ),
        ),
      ),
    );
  }
}
