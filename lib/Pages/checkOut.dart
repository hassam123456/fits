import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'cartSingleProduct.dart';
import 'cartmodel.dart';
import 'cartscreen.dart';
import 'nearbyshop.dart';

class CheckOut extends StatefulWidget {
  final String thumbnailUrl;
  final String name;
  final int price;
  final int quantity;
  final String address;

  const CheckOut(
      {Key key,
      this.name,
      this.price,
      this.thumbnailUrl,
      this.quantity,
      this.address})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int count = 1;
  TextStyle mystyle = TextStyle(
    fontSize: 18,
  );
  double total;
  @override
  Widget _buildBotttomDetail({String startName, String lastName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startName,
          style: mystyle,
        ),
        Text(
          lastName,
          style: mystyle,
        ),
      ],
    );
  }

  Position currentLocation;
  String Address = "";
  List<CartModel> myList;
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((value) async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
      setState(() {
        Address =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int subTotal = widget.price;
    // double discount = 3;
    // double discountRupees;
    // double shipping = 60;

    // discountRupees = discount / 100 * subTotal;
    // total = subTotal + shipping - discountRupees;
    return Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                    child: Text(
                      "Order Placed",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                    }),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartScreen(
                          name: widget.name,
                          price: widget.price,
                          thumbnailUrl: widget.thumbnailUrl,
                          address: widget.address,
                        )));
              },
              icon: Icon(Icons.arrow_back)),
          flexibleSpace: Container(),
          centerTitle: true,
          title: Text(
            "CheckOutPage",
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (ctx, myIndex) {
                          return CartSingleProduct(
                            index: myIndex,
                            isCount: true,
                            thumbnailUrl: widget.thumbnailUrl,
                            name: widget.name,
                            price: widget.price,
                            quantity: widget.quantity,
                          );
                        }),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Address :',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Address,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildBotttomDetail(
                          startName: "Subtotal",
                          lastName: "\Rs. ${subTotal.toStringAsFixed(2)}",
                        ),
                        // _buildBotttomDetail(
                        //   startName: "Discount",
                        //   lastName: "\Rs.${discount.toStringAsFixed(2)}%",
                        // ),
                        // _buildBotttomDetail(
                        //   startName: "Shipping",
                        //   lastName: "\Rs. ${shipping.toStringAsFixed(2)}",
                        // ),
                        // _buildBotttomDetail(
                        //   startName: "Total",
                        //   lastName: "\Rs. ${total.toStringAsFixed(2)}",
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Route route = MaterialPageRoute(builder: (c) => NearbyShops());
        Navigator.pushReplacement(context, route);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Firestore.instance.collection("shopOrders").add({
          "ProductName": widget.name,
          "ProductPrice": widget.price,
          "ProductQuetity": widget.quantity,
          "ProductImage": widget.thumbnailUrl,
          "userAddress": Address
        });
        Route route = MaterialPageRoute(builder: (c) => NearbyShops());
        Navigator.pushReplacement(context, route);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to place order?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
