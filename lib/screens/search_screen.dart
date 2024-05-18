import 'package:flutter/material.dart';
import 'package:lkw1fbase1/models/product_model.dart';
import 'package:lkw1fbase1/logics/product_logic.dart';
import 'package:lkw1fbase1/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchQuery.isEmpty) {
      return Container(); // Return an empty container when search query is empty
    }

    String? error = context.watch<ProductLogic>().error;

    if (error != null) {
      debugPrint(error);
      return Center(child: Text("Something went wrong"));
    } else {
      List<ProductModel>? productList =
          context.watch<ProductLogic>().prodctList;

      if (productList == null) {
        return Center(child: CircularProgressIndicator());
      }

      final filteredProducts = productList
          .where((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

      if (filteredProducts.isEmpty) {
        return Center(child: Text("No results found"));
      }

      return ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredProducts[index].name),
            subtitle: Text("\$${filteredProducts[index].price}"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: filteredProducts[index],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
