import 'package:cloud_firestore/cloud_firestore.dart';

class RentalModel {
  String name;
  String phone;
  String nic;
  String shippingAddress;
  Timestamp publishedDate;
  String returnDateAndTime;
  String status;
  RentalModel(
      {
        this.name,
        this.phone,
        this.nic,
        this.shippingAddress,
        this.publishedDate,
        this.returnDateAndTime,
        this.status,
      });

  RentalModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    nic = json['nic'];
    shippingAddress = json['shippingAddress'];
    publishedDate = json['publishedDate'];
    returnDateAndTime = json['returnDateAndTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['phone'] = this.phone;
    data['nic'] = this.nic;
    data['shippingAddress'] = this.shippingAddress;
    data['publishedDate'] = this.publishedDate;
    data['returnDateAndTime'] = this.returnDateAndTime;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }

    data['status'] = this.status;
    return data;
  }
}
class PublishedDate {
  String date;
  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}