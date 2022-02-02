import 'package:e_shop/Pages/product.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/provider/categoryProvider.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:provider/provider.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'List.dart';
import 'SearchCatgeory.dart';
import 'SingleProduct.dart';
import 'detailScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Product menData;
Product womenData;
Product builbdata;
Product smartPhoneData;
var featureSnapShot;
var newAchivesSnapShot;
var bridal;
var unstiched;
var stiched;
var kurti;
var saris;
CategoryProvider provider;
ProductProvider productProvider;

class _HomePageState extends State<HomePage> {
  Widget _buildCategoryFeatured(String image) {
    return CircleAvatar(
      maxRadius: 35,
      // backgroundColor: Color(0xff33dcfd),
      child: Container(
        height: 25,
      ),
      backgroundImage: AssetImage("images/$image"),
    );
  }

  Widget _buildNewArchives(BuildContext context) {
    List<Product> newAchivesProduct = productProvider.getnewAchivesList;
    return Column(
      children: [
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Beef",),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "Beef",
                                snapShot: newAchivesProduct,
                              )));
                    },
                    child: Text(
                      "View more",),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
            children: productProvider.getHomeArrivalList.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      thumbnailUrl: e.thumbnailUrl,
                                      price: e.price,
                                      name: e.name,
                                      brand: e.brand,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                  thumbnailUrl: e.thumbnailUrl,
                                  price: e.price,
                                  name: e.name,
                                  brand: e.brand),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    thumbnailUrl: e.thumbnailUrl,
                                    price: e.price,
                                    name: e.name,
                                    brand: e.brand,
                                  ),
                                ),
                              );
                            },
                            child: SingleProduct(
                                thumbnailUrl: e.thumbnailUrl,
                                price: e.price,
                                name: e.name,
                                brand: e.brand),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

  Widget _buildFeature(BuildContext context) {
    List<Product> featureProduct;
    featureProduct = productProvider.getfeatureList;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Muttons",

            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => ListProducts(
                          name: "Muttons",
                          snapShot: featureProduct,
                        )));
              },
              child: Text(
                "View more",

              ),
            )
          ],
        ),
       SizedBox(
        height: 10.0,
       ),
        Row(
          children: productProvider.getHomefeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              thumbnailUrl: e.thumbnailUrl,
                              price: e.price,
                              name: e.name,
                              brand: e.brand,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        thumbnailUrl: e.thumbnailUrl,
                        price: e.price,
                        name: e.name,
                        brand: e.brand,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            thumbnailUrl: e.thumbnailUrl,
                            price: e.price,
                            name: e.name,
                            brand: e.brand,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                      thumbnailUrl: e.thumbnailUrl,
                      price: e.price,
                      name: e.name,
                      brand: e.brand,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          // AssetImage("images/1.jpg"),
          // AssetImage("images/2.jpg"),
          // AssetImage("images/3.jpg"),
          // AssetImage("images/4.jpg"),
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
  }
   Widget _buildCategory() {
    List<Product> stiched = provider.getShirtList;
    List<Product> unstiched = provider.getunstichedList;
    List<Product> kurti = provider.getkurtiList;
    List<Product> bridal = provider.getbridalList;
    List<Product> saris = provider.getsarisList;
    return Container(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  // style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "stiched",
                                snapShot: stiched,
                              )));
                    },
                    child: _buildCategoryFeatured("8A.jpg")),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "unstiched",
                                snapShot: unstiched,
                              )));
                    },
                    child: _buildCategoryFeatured(
                      "3A.jpg",
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "kurti",
                                snapShot: kurti,
                              )));
                    },
                    child: _buildCategoryFeatured("9A.jpg")),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "bridal",
                                snapShot: bridal,
                              )));
                    },
                    child: _buildCategoryFeatured("2A.jpg")),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ListProducts(
                                name: "saris",
                                snapShot: saris,
                              )));
                    },
                    child: _buildCategoryFeatured("3A.jpg")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  double width;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CategoryProvider>(context);
    provider.getShirtData();
    provider.getbridalData();
    provider.getkrtiData();
    provider.getsarisData();
    provider.getunstichedData();
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.gethomefeatureData();
    productProvider.gethomeArrivalData();
    productProvider.getnewAchivesData();
    productProvider.getfeatureData();
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _key,
        appBar: AppBar(
          flexibleSpace: Container(
            color: Color(0xFFFEDBD0),
          ),
          title: Text(
            "GhostWalla",
          ),
          centerTitle: true,
          elevation: 0.0,

          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                   color: Colors.black,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: SearchCategory());
                }),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
                // color: Colors.white,
              ),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => CartPage());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Material(
          child: Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                      children: [
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildImageSlider(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _buildFeature(context),
                                _buildNewArchives(context),
                              ]),
                        )),
                      ],
                  )
            ),
          ));
  }
}

bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
