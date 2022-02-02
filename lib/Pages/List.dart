import 'package:e_shop/Pages/product.dart';
import 'package:e_shop/provider/categoryProvider.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'SearchCatgeory.dart';
import 'SingleProduct.dart';
import 'detailScreen.dart';
class ListProducts extends StatelessWidget {


  final String name;
  final List<Product> snapShot;
  ListProducts({
    this.name,
    this.snapShot,
  });
  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                ],
              ),

            ],
          ),
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 800,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.6 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => DetailScreen(
                    thumbnailUrl:  e.thumbnailUrl,
                    name: e.name,
                    price: e.price,
                    brand: e.brand,
                  )));
            },
            child: SingleProduct(
              price: e.price,
              thumbnailUrl: e.thumbnailUrl,
              name: e.name,
              brand: e.brand,
            ),
          ),
        )
            .toList(),
      ),
    );
  }
  CategoryProvider categoryProvider;
  ProductProvider productProvider;
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
   final Orientation orientation = MediaQuery.of(context).orientation;
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                categoryProvider.getSearchList(list: snapShot);
                showSearch(context: context, delegate: SearchCategory());
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20

        ),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}