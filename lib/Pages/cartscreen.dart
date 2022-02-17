import 'package:flutter/material.dart';
import 'package:ghostwala/provider/productProvider.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'cartSingleProduct.dart';
import 'checkOut.dart';
import 'detailScreen.dart';

class CartScreen extends StatefulWidget {
  bool isCount;
  final String thumbnailUrl;
  final String name;
  final int price;
  final int quantity;
  final String address;

  CartScreen(
      {Key key,
      this.name,
      this.price,
      this.thumbnailUrl,
      this.quantity,
      this.address})
      : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
            child: Text(
              "PlaceOrder",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => CheckOut(
                        name: widget.name,
                        price: widget.price,
                        thumbnailUrl: widget.thumbnailUrl,
                        quantity: widget.quantity,
                        address: widget.address,
                      )));
            }),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        name: widget.name,
                        price: widget.price,
                        thumbnailUrl: widget.thumbnailUrl,
                        address: widget.address,
                      )));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "CartPage",
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (ctx, index) => CartSingleProduct(
            isCount: false,
            index: index,
            thumbnailUrl: widget.thumbnailUrl,
            name: widget.name,
            price: widget.price,
            quantity: widget.quantity),
      ),
    );
  }
}
