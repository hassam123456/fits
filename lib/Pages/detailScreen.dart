import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ghostwala/Pages/shopproduct.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'cartscreen.dart';

int count = 1;

class DetailScreen extends StatefulWidget {
  final String thumbnailUrl;
  final String name;
  final int price;
  final String address;
  final String uid;

  const DetailScreen(
      {Key key,
      this.name,
      this.price,
      this.thumbnailUrl,
      this.address,
      this.uid})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<DetailScreen> {
  final TextStyle myStyle = TextStyle(fontSize: 18);

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: [
          Text(
            "Lorem ipsum, quis nostrud exercitation nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: myStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Quantity(Kg)",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
              color: Color(0xFFFEDBD0),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  child: Icon(Icons.remove),
                  onTap: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  }),
              Text(
                count.toString(),
                style: myStyle,
              ),
              GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNametoDescription() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: myStyle,
              ),
              Text(
                "\Rs ${widget.price.toString()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                "Description",
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Location> pos;
  Widget _buildmap(String name) {
    Completer<GoogleMapController> _controller = Completer();
    return Container(
      height: 200,
      child: Scaffold(
        body: GoogleMap(
          markers: {
            Marker(
              markerId: MarkerId('origin'),
              infoWindow: InfoWindow(title: name),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              position: LatLng(pos[0].latitude, pos[0].longitude),
            )
          },
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(pos[0].latitude, pos[0].longitude),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  Widget _buildButtonPart() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
              child: Text(
                "Check Out",
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => CartScreen(
                    name: widget.name,
                    price: widget.price * count,
                    thumbnailUrl: widget.thumbnailUrl,
                    quantity: count,
                    address: widget.address,
                  ),
                ));
              }),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Center(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(13),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.thumbnailUrl),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locationFromAddress(widget.address).then((res) {
      setState(() {
        pos = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ShopProducts(widget.uid, widget.address)));
          },
        ),
        flexibleSpace: Container(
          color: Color(0xFFFEDBD0),
        ),
        centerTitle: true,
        title: Text(
          "DetailPage",
        ),
        actions: <Widget>[],
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                _buildImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNametoDescription(),
                      _buildDiscription(),
                      _buildmap(widget.name),
                      _buildQuantityPart(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildButtonPart(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
