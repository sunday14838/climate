import 'package:climate/screens/loading_screen.dart';
import 'package:climate/screens/city_screen.dart';
import 'package:climate/services/location.dart';
import 'package:flutter/material.dart';
import 'package:climate/utilities/constants.dart';
import 'package:climate/services/weather.dart';
import 'package:climate/services/networking.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});

  final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel? weather = WeatherModel();
  var name;
  var weathericon;
  var longitude;
  var latitude;
  var temperature;
  var weathermessage;

  @override
  void initState() {
    super.initState();
    update(widget.locationweather);
  }

  void update(dynamic weatherdata) {
    setState(() {
      if (weatherdata==null){
        weathermessage='unable to process this due to poor connection';
        temperature=0;
        weathericon='error';
        name='';
        return;
      }
      name = weatherdata['name'];
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      weathermessage = weather!.getMessage(temperature);
      var condition = weatherdata['weather'][0]['id'];
      weathericon = weather!.getWeatherIcon(condition);
      longitude = weatherdata['coord']['lon'];
      latitude = weatherdata['coord']['lat'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather!.weather();
                      update(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedcityname=await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedcityname != null){
                        var weatherdata=await weather!.getcityweather(typedcityname);
                        update(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermessage in $name!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var name=jsonDecode(data)['name'];
// var insideweather= jsonDecode(data)['weather'][0]['main'];
// var longitude= jsonDecode(data)['coord']['lon'];
// var latitude= jsonDecode(data)['coord']['lat'];
