import 'package:climaa/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climaa/screens/location_screen.dart';
import 'package:permission_handler/permission_handler.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getGeolocationData();
  }

  Future permissionHandler() async {
    var status = await Permission.location.isGranted; // gets permission == true
    while (status == false) {
      await Permission.location.request();
      status = await Permission.location.isGranted;
    }
  }


  void getGeolocationData() async {
    await permissionHandler();
    // WeatherModel weatherModel = WeatherModel();
    // var weatherData = weatherModel.getLocationWeather();
    var weatherData = await WeatherModel().getLocationWeather();
    print(weatherData);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData,);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 120.0,
        ),
      ),
    );
  }
}
