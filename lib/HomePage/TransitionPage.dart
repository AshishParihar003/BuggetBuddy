import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jar/HomePage/icon_data.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});
  final appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        192, 255, 255, 255), // Maintain container color
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 10),
                        color:
                            Colors.grey, // Use light grey to soften the shadow
                        blurRadius: 10,
                        spreadRadius: -5, // Reduce spread to prevent overflow
                      )
                    ],
                  ),
                  child: ListTile(
                    minVerticalPadding:
                        20, // Increased vertical padding for better spacing
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: Container(
                      width: 70, // Reduced width to better fit within ListTile
                      height: 75, // Height adjusted to match width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 61, 143, 63),
                      ),
                      child: Center(
                        child: FaIcon(
                          appIcons.getExpenseCategoryIcons("home"),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    title: const Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Car Rent",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                        Text(
                          "2000",
                          style: TextStyle(
                              color: Color.fromARGB(255, 13, 56, 15),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    subtitle: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                8), // Added to give more space between title and subtitle
                        Row(
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              "525",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            )
                          ],
                        ),
                        Text(
                          "25 Oct 4:51 PM",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
