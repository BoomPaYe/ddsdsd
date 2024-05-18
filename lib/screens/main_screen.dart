import 'package:flutter/material.dart';
import 'package:lkw1fbase1/models/product_model.dart';
import 'package:lkw1fbase1/logics/product_logic.dart';
import 'package:lkw1fbase1/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> bannerImages = [
    'all_assets/logos/banner.jpg',
    'all_assets/logos/banner2.jpg',
    'all_assets/logos/banner3.jpg',
  ];
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Home",
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 237, 26, 86),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody() {
    String? error = context.watch<ProductLogic>().error;
    List<ProductModel>? productList = context.watch<ProductLogic>().prodctList;
    List<ProductModel> _filterProducts(List<ProductModel> productList) {
      if (searchQuery.isEmpty) {
        return productList;
      }

      return productList
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    if (error != null) {
      debugPrint(error);
      return Center(child: Text("Something went wrong"));
    } else if (productList == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      List<ProductModel> filteredProducts = _filterProducts(productList);
      bool isSearching = searchQuery.isNotEmpty;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.search, color: Color.fromARGB(255, 237, 26, 86)),
                hintText: 'Search',
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 16),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome to Our Shop",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing between texts and banners
                  Container(
                    height: 130, // Adjust the banner height as needed
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: PageView.builder(
                              itemCount: bannerImages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(bannerImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30), // Add some spacing between the texts
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Trending Product",
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Montserrat',
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _buildGridView(filteredProducts),
          ),
        ],
      );
    }
  }

  Widget _buildGridView(List<ProductModel>? products) {
    if (products == null) {
      return Center(
        child: Text("Something went wrong"),
      );
    }
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8, // Adjust the aspect ratio as needed
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  product: products[index],
                ),
              ),
            );
          },
          child: _buildItem(products[index]),
        );
      },
    );
  }

  Widget _buildItem(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: 4), // Adjust the bottom margin as needed
            child: Padding(
              padding:
                  EdgeInsets.only(top: 8), // Add padding to push the image down
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: 120, // Adjust the image height as desired
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8, horizontal: 8), // Adjust the padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15), // Adjust the top margin as needed
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                    height:
                        7), // Adjust the spacing between text elements as needed
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
