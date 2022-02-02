import 'package:e_shop/Pages/product.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SingleProduct.dart';
import 'detailScreen.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close,
          color: Colors.black,

        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,
        color: Colors.black,),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchCategory = providerProvider.searchProductList(query);
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailScreen(
                  thumbnailUrl: e.thumbnailUrl,
                  name: e.name,
                  price: e.price,
                ),
              ),
            );
          },
          child: SingleProduct(
            thumbnailUrl: e.thumbnailUrl,
            name: e.name,
            price: e.price,
          ),
        ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchCategory = providerProvider.searchProductList(query);
    return GridView.count(
        childAspectRatio: 0.76,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchCategory
            .map((e) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailScreen(
                 thumbnailUrl: e.thumbnailUrl,
                  name: e.name,
                  price: e.price,
                ),
              ),
            );
          },
          child: SingleProduct(
        thumbnailUrl: e.thumbnailUrl,
            name: e.name,
            price: e.price,
          ),
        ))
            .toList());
  }}