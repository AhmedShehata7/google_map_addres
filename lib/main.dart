import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  String searchAddr;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(

            initialCameraPosition:CameraPosition(
              target: LatLng(40.7128,-74.0060),
              zoom: 10.0,


            ) ,
            onMapCreated: onMapCreated,

          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Address",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0,top: 15.0),
                  suffixIcon: IconButton(icon: Icon(Icons.search),
                      onPressed:searchChanged,
                    iconSize: 30.0,
                  ),


                ),
                onChanged: (val){
                  setState(() {
                    searchAddr =val;
                  });
                },
              ),
            ),
          ),

        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  searchChanged(){
    Geolocator().placemarkFromAddress(searchAddr).then((result){
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
         target: LatLng(
           result[0].position.latitude,
             result[0].position.longitude
         ),
         zoom: 10
       ),
      )
      );
    });

  }
  void onMapCreated(controller){
    setState(() {
      mapController=controller;
    });
  }

}

