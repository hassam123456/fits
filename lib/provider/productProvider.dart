import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Pages/cartmodel.dart';
import 'package:e_shop/Pages/product.dart';

import 'package:flutter/material.dart';


class ProductProvider with ChangeNotifier {
  List<CartModel> checkOutModelList = [];
  CartModel checkOutModel;
  List <CartModel> cartModelList = [];
  CartModel cartModel;
  EcommerceApp ecommerceApp;

Future<void> getUserData() async {

}
void addOrder(){}
  void getCardData({
    int quantity,
    int price,
    String name,
    String color,
    String size,
    String thumbnailUrl,
    String brand,
  }) {
 cartModel  =     CartModel(
      color: color,
      size: size,
      price: price,
      name: name,
      thumbnailUrl: thumbnailUrl,
      quantity:  quantity,
      brand: brand,
    );
    cartModelList.add(cartModel);
  }
void deleteCartProduct(
    int index
    ){
  cartModelList.removeAt(index);
notifyListeners();
}
  void deleteCheckOutProduct(
      int index
      ){
    checkOutModelList.removeAt(index);
    notifyListeners();
  }
  void getCheckOutData({
    int quantity,
    int price,
    String name,
    String color,
    String size,
    String brand,
    String thumbnailUrl,
  }) {
    checkOutModel = CartModel(
      color: color,
      size: size,
       price: price,
      name: name,
      brand:brand,
      thumbnailUrl: thumbnailUrl,
      quantity:  quantity,

    );
    checkOutModelList.add(checkOutModel);
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }
  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }
  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
}


 int get getCartModelListLenth {
    return cartModelList.length;
  }

  List <Product> newAchives = [];
  Product newAchivesData;

//saris

  Future<void> getnewAchivesData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance.collection("product").document("kkjjkdjskjk4zzzz524lklk").collection("discountProduct")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      newAchivesData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(newAchivesData);
    }
    );
    newAchives = newList;
    notifyListeners();
  }

  List<Product> get getnewAchivesList
  {

    return newAchives;

  }
  List <Product> feature = [];
  Product featureData;

//saris

  Future<void> getfeatureData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance.collection("product").document("kkjjkdjskjk4zzzz524lklk").collection("popularProduct")
        .getDocuments();
    dressSnapShot.documents.forEach((element) {
      featureData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(featureData);
    }
    );
    feature = newList;
    notifyListeners();
  }

  List<Product> get getfeatureList
  {
    return feature;
  }

  List<Product> get getfeaturePiece

  {
    return List.from(feature);
  }



  List <Product> homeFeature = [];
  Product homeFeatureData;


  Future<void> gethomefeatureData() async{

    List<Product> newList =[];

    QuerySnapshot dressSnapShot = await Firestore.instance.collection("popularProduct").getDocuments();

    dressSnapShot.documents.forEach((element) {

      featureData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);

      newList.add(featureData);
    }

    );
    homeFeature = newList;

    notifyListeners();

  }

  List<Product> get getHomefeatureList
  {
    return homeFeature;
  }

  List <Product> homeArrival = [];
  Product homeArrivalData;

  Future<void> gethomeArrivalData() async{
    List<Product> newList =[];
    QuerySnapshot dressSnapShot = await Firestore.instance.collection("discountProduct").getDocuments();
    dressSnapShot.documents.forEach((element) {
      homeArrivalData =  Product(thumbnailUrl:  element.data["thumbnailUrl"],price: element.data["price"],name: element.data["name"],brand: element.data["brand"]);
      newList.add(homeArrivalData);

    }
    );

    notifyListeners();
    homeArrival = newList;

  }

  List<Product> get getHomeArrivalList
  {
    return homeArrival;
  }


  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
  void getSearchList({List<Product> list}) {
    void getSearchList({List<Product> list}) {
      searchList = list;
  }

}
List<Product> searchList;
}
