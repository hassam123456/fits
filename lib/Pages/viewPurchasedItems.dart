

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:flutter/material.dart';


class allData extends StatefulWidget {
  // const allData({Key? key}) : super(key: key);

  @override
  _allDataState createState() => _allDataState();
}
ProductProvider productProvider;
class _allDataState extends State<allData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('all data'),
      ),
      body:  StreamBuilder(
        stream: Firestore.instance.collection('Orders').document("documentID").collection('Product').
        snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Text('no value');
          }
          return ListView(
            children: snapshot.data.documents.map((document){
              return
                  Text(
                    document['price'].toString(),
                  );
   }).toList(),
          );
        }
      )
    );
  }
}
