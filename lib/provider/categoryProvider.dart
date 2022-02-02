import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Pages/product.dart';
import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier{

  List <Product> unstiched = [];
  Product unstichedData;

  List <Product> shirt = [];
  Product shirtData;

  List <Product> kurti = [];
  Product kurtiData;

  List <Product> bridal = [];
  Product bridalData;


  List <Product> saris = [];
  Product sarisData;

//saris

  Future<void> getsarisData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance
        .collection("category")
        .document("kkjjkdjskjk4zzzz524lklk")
        .collection("saris")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      sarisData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(sarisData);
    }
    );
    saris = newList;
    notifyListeners();
  }

  List<Product> get getsarisList
  {
    return saris;
  }




//bridal
  Future<void> getbridalData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance
        .collection("category")
        .document("kkjjkdjskjk4zzzz524lklk")
        .collection("bridal")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      bridalData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(bridalData);
    }
    );
    bridal = newList;
  }

  List<Product> get getbridalList
  {
    return bridal;
  }




//kurti
  Future<void> getkrtiData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance
        .collection("category")
        .document("kkjjkdjskjk4zzzz524lklk")
        .collection("Kurti")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      kurtiData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(kurtiData);
    }
    );
    kurti = newList;
  }

  List<Product> get getkurtiList
  {
    return kurti;
  }

//unstiched

  Future<void> getunstichedData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance
        .collection("category")
        .document("kkjjkdjskjk4zzzz524lklk")
        .collection("Unstiched")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      unstichedData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(unstichedData);
    }
    );
    unstiched = newList;
  }
  List<Product> get getunstichedList
  {
    return unstiched;
  }
//stiched


  Future<void> getShirtData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance.collection("category").document("kkjjkdjskjk4zzzz524lklk").collection("stiched")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      shirtData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(shirtData);
    }
    );
    shirt = newList;
  }
  List<Product> get getShirtList
   {
     return shirt;
   }

   List <Product> searchList;
void getSearchList({List<Product> list})
{
  searchList = list;
}

  List<Product> searchCategoryList(String query){
    List<Product> searchShirt = shirt.where((element) {
      return element.brand.toUpperCase().contains(query)||
          element.brand.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}