import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'SearchCatgeory.dart';
import 'SingleProduct.dart';
import 'detailScreen.dart';
import 'nearbyshop.dart';

class ShopProducts extends StatefulWidget {
  final String uid;
  final String address;
  ShopProducts(this.uid, this.address);
  @override
  _ShopProductsState createState() => _ShopProductsState();
}

class _ShopProductsState extends State<ShopProducts> {
  List shops = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // calculateDistance();
    read(widget.uid).then((value) {
      setState(() {
        shops = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NearbyShops()));
          },
        ),
        flexibleSpace: Container(
          color: Color(0xFFFEDBD0),
        ),
        centerTitle: true,
        title: Text(
          "Products",
        ),
        actions: <Widget>[],
      ),
      body: Container(
          height: 800,
          child: ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, index) {
                while (shops.isEmpty) {
                  return CircularProgressIndicator();
                }
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailScreen(
                              name: shops[index]['name'],
                              price: shops[index]['price'],
                              thumbnailUrl: shops[index]['thumbnailUrl'],
                              address: widget.address,
                              uid: widget.uid,
                            )));
                  },
                  child: SingleProduct(
                    name: shops[index]['name'],
                    price: shops[index]['price'],
                    thumbnailUrl: shops[index]['thumbnailUrl'],
                    desc: shops[index]['status'],
                  ),
                );
              })),
    );
  }

  Future<List> read(String uid) async {
    QuerySnapshot querySnapshot;
    FirebaseUser _fuser;
    List docs = [];
    try {
      querySnapshot = await Firestore.instance
          .collection("shops")
          .document(uid)
          .collection('products')
          .getDocuments();
      if (querySnapshot.documents.isNotEmpty) {
        for (var doc in querySnapshot.documents.toList()) {
          Map a = {
            "longDescription": doc['longDescription'],
            "price": doc["price"],
            "thumbnailUrl": doc["thumbnailUrl"],
            "status": doc["status"],
            "name": doc["name"],
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }
}
