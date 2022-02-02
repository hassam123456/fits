import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'cartSingleProduct.dart';
import 'cartmodel.dart';
class  CheckOut extends StatefulWidget {


  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int count =1;
  TextStyle mystyle = TextStyle(
    fontSize: 18,
  );
  double total;
  @override
  Widget _buildBotttomDetail({String startName, String lastName}){
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startName,style: mystyle,),
        Text(lastName,
          style: mystyle,),
 ],
    );
  }
  List<CartModel> myList;
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quantity;
    });

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }
    return Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(
              bottom: 10
          ),
          child: Column(
            children: [
              Container(
                child: ElevatedButton(

                    child: Text(
                      "Order Placed",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                    onPressed: ()
                    {
                        Firestore.instance.collection("Orders").add({
                          "Product": productProvider.getCheckOutModelList
                              .map((c) => {
                            "ProductName": c.name,
                            "ProductPrice": c.price,
                            "ProductQuetity": c.quantity,
                            "ProductImage": c.thumbnailUrl,
                            "Brand": c.brand,
                          })
                              .toList(),

                        });
                        Route route = MaterialPageRoute(builder: (c) => HomePage());
                        Navigator.pushReplacement(context, route);

                                }

                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(

          flexibleSpace: Container(
          // color: Colors.cyan,
          ),
          centerTitle: true,
          title: Text(
            "CheckOutPage",
            style: TextStyle(
                fontSize: 55.0, color: Colors.black, fontFamily: "Signatra"),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,
            vertical: 15,
          ),
     child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    Expanded(
      flex: 2,
      child: Container(
        child: ListView.builder(
        itemCount: productProvider.getCheckOutModelListLength,

        itemBuilder: (ctx,myIndex) {


          return CartSingleProduct(
            index: myIndex,
            isCount: true,
            thumbnailUrl: productProvider.getCheckOutModelList[myIndex].thumbnailUrl,
            name: productProvider.getCheckOutModelList[myIndex].name,
            price: productProvider.getCheckOutModelList[myIndex].price,
            quantity: productProvider.getCheckOutModelList[myIndex].quantity,
          );
        }),
      ),
    ),

            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBotttomDetail(
                      startName: "Subtotal",
                      lastName: "\Rs. ${subTotal.toStringAsFixed(2)}",
                    ),
                    _buildBotttomDetail(
                      startName: "Discount",
                      lastName: "\Rs.${discount.toStringAsFixed(2)}%",
                    ),
                    _buildBotttomDetail(
                      startName: "Shipping",
                      lastName: "\Rs. ${shipping.toStringAsFixed(2)}",
                    ),
                    _buildBotttomDetail(
                      startName: "Total",
                      lastName: "\Rs. ${total.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
            )],

                )
    ));

                  }
  }
