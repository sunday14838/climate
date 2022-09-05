import 'package:geolocator/geolocator.dart';

class Getcurrentlocation{
  late double longitude;
  late double latitude;

  Future getLoc() async{
    try{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude=position.longitude;
    latitude=position.latitude;}
    catch(e){
      print(e);
    }
  }

}