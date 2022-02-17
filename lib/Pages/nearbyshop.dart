// ignore_for_file: file_names

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ghostwala/Pages/shopproduct.dart';
import 'package:ghostwala/Widgets/myDrawer.dart';

class NearbyShops extends StatefulWidget {
  @override
  State<NearbyShops> createState() => _NearbyNgosState();
}

class _NearbyNgosState extends State<NearbyShops> {
  List shops = [];
  List distances = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // calculateDistance();
    read().then((value) {
      setState(() {
        shops = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       // showSearch(context: context, delegate: SearchCategory());
          //     }),
          // IconButton(
          //   icon: Icon(
          //     Icons.shopping_cart,
          //     color: Colors.black,
          //     // color: Colors.white,
          //   ),
          //   onPressed: () {
          //     // Route route = MaterialPageRoute(builder: (c) => CartPage());
          //     // Navigator.pushReplacement(context, route);
          //   },
          // ),
        ],
      ),
      drawer: MyDrawer(),
      body: ngocard(),
    );
  }

  Widget ngocard() {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: const Text(
            'Shops Around You',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.8,
            margin: const EdgeInsets.only(top: 10),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  while (shops.isEmpty) {
                    return CircularProgressIndicator();
                  }
                  double distance = calculateDistance(shops[index]['address']);
                  print('Distance is : ${(distance)} $index');
                  print(distances);

                  if (distance > 500) {
                    return buildCard(
                        shops[index]['name'],
                        shops[index]['address'],
                        shops[index]['email'],
                        index,
                        shops[index]['uid']);
                  } else {
                    return SizedBox();
                  }
                })),
      ],
    );
  }

  Widget buildCard(
      String name, String address, String ngoId, int cardIndex, String uid) {
    // double dis = calculateDistance(address);
    // if (dis > 0) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.blue[800],
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'))),
            ),
          ]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          FittedBox(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          FittedBox(
            child: Text(
              address,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopProducts(uid, address)),
                          );
                        },
                        child: const Text(
                          'View Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ))))
        ],
      ),
      margin: cardIndex.isEven
          ? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
          : const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0),
    );
  }
// else {
//   return Center(child: Text('No Nearby Shops found'));
// }
}

Position _currentUserPosition;
double distanceImMeter = 0.0;
double calculateDistance(String address) {
  int distanceInKm;
  int distance;
  locationFromAddress(address).then((result) async {
    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double ngolat = result[0].latitude;
    double ngolng = result[0].longitude;
    distanceImMeter = Geolocator.distanceBetween(
      _currentUserPosition.latitude,
      _currentUserPosition.longitude,
      ngolat,
      ngolng,
    );
  });

  return distanceImMeter;
}

Future<List> read() async {
  QuerySnapshot querySnapshot;
  FirebaseUser _fuser;
  List docs = [];
  try {
    querySnapshot = await Firestore.instance.collection("shops").getDocuments();
    if (querySnapshot.documents.isNotEmpty) {
      for (var doc in querySnapshot.documents.toList()) {
        Map a = {
          "name": doc['name'],
          "email": doc["email"],
          "address": doc["address"],
          "contactNo": doc["contactNo"],
          "uid": doc["uid"],
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