
import 'package:e_shop/Pages/product.dart';
import 'package:e_shop/provider/categoryProvider.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'SingleProduct.dart';

class SearchCategory extends SearchDelegate<void>
{
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon:  Icon(
          Icons.close
        ),
        onPressed: (){
        query  = "";
        },
      )
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon:  Icon(
          Icons.arrow_back
      ),
      onPressed: (){
   close(context, null);

      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   CategoryProvider categoryProvider = Provider.of(context);
    List<Product> searchCategory =  categoryProvider.searchCategoryList(query);

    return GridView.count(crossAxisCount: 2,
    childAspectRatio: 0.87,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    children: searchCategory.map((e) => SingleProduct(
      thumbnailUrl: e.thumbnailUrl,
      name: e.name,
       brand: e.brand,
      price: e.price,
    )).toList(),
   );
  }
void getProduct(){}
  @override
  Widget buildSuggestions(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    List<Product> searchCategory =  provider.searchCategoryList(query);

    return GridView.count(crossAxisCount: 2,
      childAspectRatio: 0.65,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,

      children: searchCategory.map((e) => SingleProduct(
        thumbnailUrl: e.thumbnailUrl,
        name: e.name,
        price: e.price,
        brand: e.brand,
      )).toList(),
    );

  }
  }

