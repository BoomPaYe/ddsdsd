import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Cart",
      ),
      backgroundColor: Color.fromARGB(255, 237, 26, 86),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading:
          false, // Prevents the back button from appearing
    );
  }
}
