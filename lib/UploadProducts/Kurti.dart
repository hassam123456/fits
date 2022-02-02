// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_shop/Authentication/authenication.dart';
// import 'package:e_shop/Widgets/loadingWidget.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Kurti extends StatefulWidget
// {
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }
//
// class _UploadPageState extends State<Kurti> with AutomaticKeepAliveClientMixin<Kurti>
// {
//   bool get wantKeepAlive => true;
//   File file;
//   TextEditingController _brandTextEditingController = TextEditingController();
//   TextEditingController _priceTextEditingController = TextEditingController();
//   TextEditingController _nameTextEditingController = TextEditingController();
//   String productId = DateTime.now().millisecondsSinceEpoch.toString();
//   bool uploading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return file == null? displayAdminHomeScreen() : displayAdminUploadFormScreen();
//   }
//
//   displayAdminHomeScreen(){
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//
//         ),
//         leading: IconButton(
//
//           icon: Icon(Icons.arrow_back),
//           onPressed: (){
//             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) =>  UploadPages()));
//           },
//         ),
//         actions: [
//           ElevatedButton(
//             child: Text(
//               "Logout",
//               style: TextStyle(
//                   color: Colors.pink,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//             onPressed: (){
//               Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
//               Navigator.pushReplacement(context, route);
//             },
//           ),
//         ],
//       ),
//       body: getHomeScreenBody(
//
//       ),
//     );
//   }
//   getHomeScreenBody(){
//     return Container(
//       // color: Colors.cyan,
//
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.shop_two,color: Colors.white,size: 200.0,),
//
//             Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: RaisedButton(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
//                     child: Text("Kurti",style: TextStyle(color: Colors.white,fontSize: 20.0),),
//                     // color: Colors.cyan,
//                     onPressed: ()
//                     => takeImage(context))
//             ),
//
//             //  Container(
//             // //   height: 220,
//             //    child: UploadPages(),
//             //  )
//           ],
//         ),
//       ),
//     );
//   }
//   takeImage(mContext){
//     return showDialog(
//         context: mContext,
//         builder: (con){
//           return SimpleDialog(
//             title: Text("ItemImage",style: TextStyle(color: Color(0xFFFEDBD0), fontWeight: FontWeight.bold),),
//             children: [
//               SimpleDialogOption(
//                   child: Text("Capture With Camera",style: TextStyle(color: Color(0xFFFEDBD0)),),
//                   onPressed: capturePhotoWithCamera
//               ),
//               SimpleDialogOption(
//                   child: Text("Select From Gallery",style: TextStyle(color: Color(0xFFFEDBD0)),),
//                   onPressed: pickPhotoFromGallery
//               ),
//               SimpleDialogOption(
//                   child: Text("Cancel",style: TextStyle(color: Color(0xFFFEDBD0)),),
//                   onPressed: (){
//                     Navigator.pop(context);
//                   }
//               ),
//             ],
//           );
//         }
//     );
//   }
//
//   capturePhotoWithCamera() async{
//     Navigator.pop(context);
//     File imageFile= await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
//
//     setState(() {
//       file = imageFile;
//     });
//   }
//
//   pickPhotoFromGallery() async{
//     Navigator.pop(context);
//     File imageFile= await ImagePicker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       file = imageFile;
//     });
//   }
//
//
//   displayAdminUploadFormScreen(){
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           // decoration: BoxDecoration(
//           //   gradient: LinearGradient(
//           //     colors: [Colors.pink,
//           //       Colors.greenAccent],
//           //     begin: const FractionalOffset(0.0,0.0),
//           //     end: const FractionalOffset(1.0,0.0),
//           //     stops: [0.0,1.0],
//           //     tileMode: TileMode.clamp,
//           //   ),
//           // ),
//         ),
//         leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: clearFormInfo,),
//         title: Text("New Product",style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),),
//         actions: [
//           ElevatedButton(
//             onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
//             child: Text("Add",
//               style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0),
//
//             ),
//           ),
//         ],
//       ),
//
//       body: ListView(
//         children: [
//           uploading ? circularProgress() : Text(""),
//           Container(
//             height: 230.0,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Center(
//               child: AspectRatio(
//                 aspectRatio: 16/9,
//                 child: Container(
//                   decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
//                 ),
//               ),
//             ),
//
//           ),
//           Padding(padding: EdgeInsets.only(top: 12.0)),
//           ListTile(
//             leading: Icon(Icons.perm_device_information,
//               color: Colors.black
//             ),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 style: TextStyle(color: Colors.black),
//                 controller: _nameTextEditingController,
//                 decoration: InputDecoration(
//                     hintText: "Name",
//                     hintStyle: TextStyle(color: Colors.black),
//                     border: InputBorder.none
//                 ),
//               ),
//             ),
//           ),
//           Divider(color: Color(0xFFFEDBD0),
//           ),
//
//
//           ListTile(
//             leading: Icon(Icons.perm_device_information,color: Colors.black,),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 style: TextStyle(color: Colors.black),
//                 controller: _priceTextEditingController,
//                 decoration: InputDecoration(
//                     hintText: "Price",
//                     hintStyle: TextStyle(color: Colors.black),
//                     border: InputBorder.none
//                 ),
//               ),
//             ),
//           ),
//
//
//           Divider(color: Color(0xFFFEDBD0),),
//           Padding(padding: EdgeInsets.only(top: 12.0)),
//           ListTile(
//             leading: Icon(Icons.perm_device_information,color: Colors.black,),
//             title: Container(
//               width: 250.0,
//               child: TextField(
//                 style: TextStyle(color: Colors.black),
//                 controller: _brandTextEditingController,
//                 decoration: InputDecoration(
//                     hintText: "Brand",
//                     hintStyle: TextStyle(color: Colors.black),
//                     border: InputBorder.none
//                 ),
//               ),
//             ),
//           ),
//
//
//
//
//
//         ],
//       ),
//     );
//   }
//
//
//   clearFormInfo(){
//     setState(() {
//       file = null;
//       _nameTextEditingController.clear();
//       _priceTextEditingController.clear();
//       _brandTextEditingController.clear();
//     });
//   }
//   uploadImageAndSaveItemInfo() async{
//     setState(() {
//       uploading = true;
//     });
//     String imageDownloadUrl = await uploadItemImage(file);
//
//     saveItemInfo(imageDownloadUrl);
//   }
//   Future<String> uploadItemImage(mFileImage) async{
//     final StorageReference storageReference = FirebaseStorage.instance.ref().child("Items");
//     StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   saveItemInfo( String downloadUrl){
//     final itemsRef = Firestore.instance.collection("category").document("kkjjkdjskjk4zzzz524lklk").collection("Kurti");
//     itemsRef.document(productId).setData({
//       "price" : int.parse(_priceTextEditingController.text),
//       "thumbnailUrl" : downloadUrl,
//       "name" : _nameTextEditingController.text.trim(),
//       "brand" : _brandTextEditingController.text.trim(),
//     });
//     setState(() {
//       file = null;
//       uploading = false;
//       productId = DateTime.now().millisecondsSinceEpoch.toString();
//       _nameTextEditingController.clear();
//       _brandTextEditingController.clear();
//       _priceTextEditingController.clear();
//     });
//   }
// }
