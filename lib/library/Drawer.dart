import 'package:flutter/material.dart';

class SliderBar extends StatefulWidget {
  const SliderBar({super.key});

  @override
  State<SliderBar> createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Container(
        //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        //   constraints: const BoxConstraints(maxWidth: 288),
        //   decoration: const BoxDecoration(color: Colors.deepOrangeAccent),
        //   child: const Column(
        //     children: [
        //       Row(
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Colors.white24,
        //             foregroundColor: Colors.white,
        //             child: Icon(Icons.person_2_outlined),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
