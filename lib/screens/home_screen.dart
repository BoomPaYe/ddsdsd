import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lkw1fbase1/screens/cart_screen.dart';
import 'package:lkw1fbase1/screens/main_screen.dart';
import 'package:lkw1fbase1/screens/product_screen.dart';
import 'package:lkw1fbase1/screens/profile_screen.dart';
import 'package:lkw1fbase1/screens/search_screen.dart';
import 'package:lkw1fbase1/models/product_model.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         await FirebaseAuth.instance.signOut();
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(
      //             builder: (context) => LoginScreen(),
      //           ),
      //         );
      //       },
      //       icon: Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
    );
  }

// Define the cartItems list
  List<ProductModel> cartItems = []; // Define an empty list initially
  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        MainScreen(),
        CartScreen(),
        ProductScreen(),
        ProfileScreen(),
      ],
    );
  }

  int _currentIndex = 0;

  Widget _buildBottom() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (selectedIndex) {
        setState(() {
          _currentIndex = selectedIndex;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 237, 26, 86),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Profile"),
      ],
    );
  }
}
