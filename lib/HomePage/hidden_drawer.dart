// import 'package:flutter/material.dart';
// import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

// import 'package:jar/library/home.dart';

// class HiddenDrawer extends StatefulWidget {
//   const HiddenDrawer({super.key});

//   @override
//   State<HiddenDrawer> createState() => _HiddenDrawerState();
// }

// class _HiddenDrawerState extends State<HiddenDrawer> {
//   List<ScreenHiddenDrawer> _pages = [];

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       ScreenHiddenDrawer(
//           ItemHiddenMenu(
//               name: "Setting",
//               baseStyle: TextStyle(),
//               selectedStyle: TextStyle()),
//           Setting()),
//       ScreenHiddenDrawer(
//           ItemHiddenMenu(
//               name: "Home", baseStyle: TextStyle(), selectedStyle: TextStyle()),
//           Home()),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HiddenDrawerMenu(
//       backgroundColorMenu: Colors.blue,
//       initPositionSelected: 0,
//       screens: _pages,
//     );
//   }
// }

// class Setting extends StatelessWidget {
//   const Setting({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
