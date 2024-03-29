// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_shop/Admin/adminShiftOrders.dart';
// import 'package:e_shop/Authentication/authenication.dart';
// import 'package:e_shop/Pages/UploadPages.dart';
// import 'package:e_shop/Widgets/loadingWidget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadPage extends StatefulWidget {
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }
//
// class _UploadPageState extends State<UploadPage>
//     with AutomaticKeepAliveClientMixin<UploadPage> {
//   bool get wantKeepAlive => true;
//   File file;
//   TextEditingController _descriptionTextEditingController =
//       TextEditingController();
//   TextEditingController _priceTextEditingController = TextEditingController();
//   TextEditingController _titleTextEditingController = TextEditingController();
//   TextEditingController _shortInfoTextEditingController =
//       TextEditingController();
//   String productId = DateTime.now().millisecondsSinceEpoch.toString();
//   bool uploading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return file == null
//         ? displayAdminHomeScreen()
//         : displayAdminUploadFormScreen();
//   }
//
//   displayAdminHomeScreen() {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,
//           color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (ctx) => UploadPages()));
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.border_color,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Route route =
//                   MaterialPageRoute(builder: (c) => AdminShiftOrders());
//               Navigator.pushReplacement(context, route);
//             },
//           ),
//           ElevatedButton(
//             child: Text(
//               "Logout",
//             ),
//             onPressed: () {
//               Route route =
//                   MaterialPageRoute(builder: (c) => AuthenticScreen());
//               Navigator.pushReplacement(context, route);
//             },
//           ),
//         ],
//       ),
//       body: getAdminHomeScreenBody(),
//     );
//   }
//
//   getAdminHomeScreenBody() {
//     return Container(
//       // color: Colors.greenAccent,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.shop_two,
//               size: 200.0,
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 20.0),
//               child: ElevatedButton(
//                 child: Text(
//                   "Upload Rental Clothes",
//                 ),
//                 // color: Colors.cyan,
//                 onPressed: () => takeImage(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   takeImage(mContext) {
//     return showDialog(
//         context: mContext,
//         builder: (con) {
//           return SimpleDialog(
//             title: Text(
//               "Item Image",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             children: [
//               SimpleDialogOption(
//                 child: Text("Capture with Camera",
//                     style: TextStyle(
//                       color: Colors.black,
//                     )),
//                 onPressed: capturePhotoWithCamera,
//               ),
//               SimpleDialogOption(
//                 child: Text("Select from Gallery",
//                     style: TextStyle(
//                       color: Colors.black,
//                     )),
//                 onPressed: pickPhotoFromGallery,
//               ),
//               SimpleDialogOption(
//                 child: Text("Cancel",
//                     style: TextStyle(
//                       color: Colors.black,
//                     )),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   capturePhotoWithCamera() async {
//     Navigator.pop(context);
//     File imageFile = await ImagePicker.pickImage(
//         source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
//
//     setState(() {
//       file = imageFile;
//     });
//   }
//
//   pickPhotoFromGallery() async {
//     Navigator.pop(context);
//     File imageFile = await ImagePicker.pickImage(
//       source: ImageSource.gallery,
//     );
//
//     setState(() {
//       file = imageFile;
//     });
//   }
//
//   displayAdminUploadFormScreen() {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(),
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: clearFormInfo),
//         title: Text(
//           "New Product",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
//             child: Text(
//               "Add",
//               style: TextStyle(
//                 color:  Colors.black,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           uploading ? circularProgress() : Text(""),
//           Container(
//             height: 230.0,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Center(
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: FileImage(file), fit: BoxFit.cover)),
//                 ),
//               ),
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(top: 12.0)),
//           ListTile(
//             leading: Icon(
//               Icons.perm_device_information,
//               color: Colors.black,
//             ),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 style: TextStyle(color: Colors.black),
//                 controller: _shortInfoTextEditingController,
//                 decoration: InputDecoration(
//                   hintText: "Short Info",
//                   hintStyle: TextStyle(color: Colors.black),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Divider(
//             color:  Color(0xFFFEDBD0),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.perm_device_information,
//               color:  Color(0xFFFEDBD0),
//             ),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 style: TextStyle(color: Colors.black),
//                 controller: _titleTextEditingController,
//                 decoration: InputDecoration(
//                   hintText: "Title",
//                   hintStyle: TextStyle(color: Colors.black),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Divider(
//             color:  Color(0xFFFEDBD0),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.perm_device_information,
//             ),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 style: TextStyle(),
//                 controller: _descriptionTextEditingController,
//                 decoration: InputDecoration(
//                   hintText: "Description",
//                   hintStyle: TextStyle(),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Divider(
//             color:  Color(0xFFFEDBD0),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.perm_device_information,
//               color: Colors.black,
//             ),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 // style: TextStyle(color: Colors.deepPurpleAccent),
//                 controller: _priceTextEditingController,
//                 decoration: InputDecoration(
//                   hintText: "Price",
//                   hintStyle:
//                   TextStyle(
//                     color:  Color(0xFFFEDBD0),
//                   ),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Divider(
//             color:  Color(0xFFFEDBD0),
//           )
//         ],
//       ),
//     );
//   }
//
//   clearFormInfo() {
//     setState(() {
//       file = null;
//       _descriptionTextEditingController.clear();
//       _priceTextEditingController.clear();
//       _shortInfoTextEditingController.clear();
//       _titleTextEditingController.clear();
//     });
//   }
//
//   uploadImageAndSaveItemInfo() async {
//     setState(() {
//       uploading = true;
//     });
//
//     String imageDownloadUrl = await uploadItemImage(file);
//
//     saveItemInfo(imageDownloadUrl);
//   }
//
//   Future<String> uploadItemImage(mFileImage) async {
//     final StorageReference storageReference =
//         FirebaseStorage.instance.ref().child("shops");
//     StorageUploadTask uploadTask =
//         storageReference.child("product_$productId.jpg").putFile(mFileImage);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   saveItemInfo(String downloadUrl) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseUser user = await _auth.currentUser();
//     final userid = user.uid;
//     final itemsRef = Firestore.instance.collection("shops").document(userid).collection("products");
//     itemsRef.document(productId).setData({
//       "shortInfo": _shortInfoTextEditingController.text.trim(),
//       "longDescription": _descriptionTextEditingController.text.trim(),
//      "price": int.parse(_priceTextEditingController.text),
//       "publishedDate": DateTime.now(),
//       "status": "available",
//       "thumbnailUrl": downloadUrl,
//       "title": _titleTextEditingController.text.trim(),
//     });
//
//     setState(() {
//       file = null;
//       uploading = false;
//       productId = DateTime.now().millisecondsSinceEpoch.toString();
//       _descriptionTextEditingController.clear();
//       _titleTextEditingController.clear();
//       _shortInfoTextEditingController.clear();
//       _priceTextEditingController.clear();
//     });
//   }
// }
