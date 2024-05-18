import 'package:flutter/material.dart';
import 'package:lkw1fbase1/logics/product_logic.dart';
import 'package:lkw1fbase1/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:lkw1fbase1/screens/product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String _selectedFilter = 'A-Z'; // Default filter option

  @override
  void initState() {
    super.initState();
    context.read<ProductLogic>().readProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Menu"),
      centerTitle: true,
      backgroundColor:
          Color.fromARGB(255, 237, 26, 86), // Set the app bar background color
      elevation: 0,
      automaticallyImplyLeading: false, // Remove the app bar shadow
    );
  }

  Widget _buildBody() {
    String? error = context.watch<ProductLogic>().error;

    if (error != null) {
      debugPrint(error);
      return Center(child: Text("Something went wrong"));
    } else {
      List<ProductModel>? productList =
          context.watch<ProductLogic>().prodctList;
      return Column(
        children: [
          _buildFilterButton(),
          Expanded(
            child: _buildListView(productList),
          ),
        ],
      );
    }
  }

  Widget _buildFilterButton() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            'Filter:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.0),
          DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
            items: <String>['A-Z', 'Z-A']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<ProductModel>? products) {
    if (products == null) {
      return Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator while products are being fetched
      );
    }

    // Apply the selected filter
    if (_selectedFilter == 'A-Z') {
      products.sort((a, b) => a.name.compareTo(b.name));
    } else if (_selectedFilter == 'Z-A') {
      products.sort((a, b) => b.name.compareTo(a.name));
    }

    return Container(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProduct(products[index]);
        },
      ),
    );
  }

  Widget _buildProduct(ProductModel product) {
    String price = '\$${product.price}';
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 237, 26, 86),
                  ),
                  child: Text('View Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
