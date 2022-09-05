import 'dart:convert';

import 'package:climate/screens/location_screen.dart';
import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';
import 'package:climate/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climate/services/location.dart';

import 'package:climate/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
 late double longitude;

  @override
  void initState() {

        Future <LocationPermission> permission= ( Geolocator.requestPermission()) as Future<LocationPermission>;

    getlocation();
    super.initState();
  }

  void getlocation()async{
    WeatherModel weatherModel=WeatherModel();
    var weatherdata=await weatherModel.weather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: weatherdata);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dog.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SpinKitRing(color: Colors.blue,size: 100,),
        ),
      ),

    );
  }
}
