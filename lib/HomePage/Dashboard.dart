import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:hidden_drawer_menu/hidden_drawer_menu.dart";
import "package:jar/HomePage/TransitionPage.dart";
import "package:jar/Signup.dart/signup.dart";

import "AddTransactionForm.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [];
  }

  var isLogoutLoading = false;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  _dialoBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: AddTransactionForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTransactionForm()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.exit_to_app),
          )
        ],
        title: const Text("Hello, Sir"),
      ),
      drawer: const Drawer(),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SingleChildScrollView(
          child: Column(
            children: [const HeroCard(), TransactionScreen()],
          ),
        ),
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
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

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 219, 113, 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Total Balance",
              style: TextStyle(
                  fontSize: 45, height: 1.2, fontWeight: FontWeight.bold),
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
                  child: const Row(children: [
                    CardOne(
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    CardOne(
                      color: Colors.red,
                    )
                  ])),
            ],
          )
        ],
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({super.key, required this.color});

  final Color color;

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
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                // Making the first column take up all available space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Align items to center vertically
                  children: [
                    Text(
                      "Credit",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 8, 36),
                          fontSize:
                              30, // Adjusted for better fit and aesthetics
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹ 5850",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 12, 120),
                          fontSize: 28, // Adjusted for consistency
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.arrow_upward_outlined,
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
