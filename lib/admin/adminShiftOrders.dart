import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderCard.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/admin/uploadItems.dart';
import 'package:flutter/material.dart';
import '../Widgets/loadingWidget.dart';
class AdminShiftOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<AdminShiftOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
           iconTheme: IconThemeData(
               color: Colors.black,
           ),
           centerTitle: true,
          title: Text("My Orders", style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back,
              color: Colors.black,
              ),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) =>  UploadPage()));
              },
            ),],
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .snapshots(),
          builder: (c, snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (c, index){
                return FutureBuilder<QuerySnapshot>(
                  future: Firestore.instance
                      .collection("items")
                      .where("shortInfo", whereIn: snapshot.data.documents[index].data[EcommerceApp.productID])
                      .getDocuments(),
                  builder: (c, snap)
                  {
                    return snap.hasData
                        ? AdminOrderCard(
                      itemCount: snap.data.documents.length,
                      data: snap.data.documents,
                      orderID: snapshot.data.documents[index].documentID,
                      orderBy: snapshot.data.documents[index].data["orderBy"],
                      addressID: snapshot.data.documents[index].data["addressID"],
                    )
                        : Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
