import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';


const apiKey='29770fd8275a10f2b3fc89ec798f4059';
class WeatherModel {

  Future getcityweather(String cityname)async {
    Network network = Network(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric");

    var weatherdata = await network.getdata();
    return weatherdata;
  }

  Future weather()async{
    Getcurrentlocation location=Getcurrentlocation();
    await location.getLoc();

    Network network=Network("https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");

    var weatherdata= await network.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
