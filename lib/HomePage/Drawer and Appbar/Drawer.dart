import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('johndoe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'JD',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: const Text('Option 1'),
            onTap: () {
              // Update the state of the app
              // Close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Option 2'),
            onTap: () {
              // Update the state of the app
              // Close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Option 3'),
            onTap: () {
              // Update the state of the app
              // Close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Option 4'),
            onTap: () {
              // Update the state of the app
              // Close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  }
