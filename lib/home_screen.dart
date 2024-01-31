// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_design/constants/api_key.dart';
import 'package:mobile_design/constants/temperature_icon.dart';
import 'package:mobile_design/widgets/location_info.dart';
import 'package:mobile_design/widgets/temperature.dart';
import 'package:mobile_design/utils.dart';
import 'package:mobile_design/widgets/weather_info_row.dart';
import 'package:weather/weather.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController cityController = TextEditingController();
  String cityName = "Bhubaneswar";
  String humidity = '';
  String sunriseTime = '';
  String sunsetTime = '';
  String temperature = '';
  Weather? weather;
  String weatherDescription = '';
  String weatherMain = '';
  String windSpeed = '';
  late WeatherFactory ws;

  late StreamController<DateTime> _streamController;
  late Timer _timer;

  @override
  void dispose() {
    _streamController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ws = WeatherFactory(apiKey, language: Language.ENGLISH);
    fetchWeatherInfo();
    _streamController = StreamController<DateTime>();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(DateTime.now());
    });
  }

  Future<void> fetchWeatherInfo() async {
    try {
      Weather weather = await ws.currentWeatherByCityName(cityName);
      temperature = '${weather.temperature?.celsius?.toStringAsFixed(1)}';
      DateTime? sunrise = weather.sunrise;
      sunriseTime = '${sunrise?.hour}:${sunrise?.minute}';
      DateTime? sunset = weather.sunset;
      sunsetTime = '${sunset?.hour}:${sunset?.minute}';
      windSpeed = '${weather.windSpeed?.toStringAsFixed(2)} m/s';
      humidity = '${weather.humidity}%';
      weatherMain = "${weather.weatherMain}";
      weatherDescription = "${weather.weatherDescription}";
      print("weather: $weather");
      setState(() {});
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        temperature = 'N/A';
        sunriseTime = 'N/A';
        sunsetTime = 'N/A';
        windSpeed = 'N/A';
        humidity = 'N/A';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 10),
      //       child: IconButton(
      //           onPressed: () async {
      //             String? selectedCity =
      //                 await showCityDialog(context, cityController);
      //             if (selectedCity != null && selectedCity.isNotEmpty) {
      //               setState(() {
      //                 cityName = selectedCity;
      //               });
      //               fetchWeatherInfo();
      //             }
      //           },
      //           icon: const Icon(Icons.add)),
      //     ),
      //   ],
      // ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 5,
              image: AssetImage('assets/images/foggy_weather.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            //filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            filter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
            child: Column(
              children: [
                const SizedBox(height: 100),
                LocationInfo(
                    cityName: cityName, streamController: _streamController),
                const SizedBox(height: 50),
                WeatherIconHelper.getTemperatureIcon(
                  double.tryParse(temperature),
                  weatherMain,
                  weatherDescription,
                ),
                Text(weatherMain),
                const SizedBox(height: 50),
                TemperatureWidget(temperature: temperature),
                Text(getGreetingMessage(DateTime.now())),
                const Text("Atanu", style: TextStyle(fontSize: 25)),
                const SizedBox(height: 120),
                WeatherInfoRow(
                  sunEventIcon: getSunEventIcon(sunriseTime),
                  sunEventTitle: getSunEventTitle(sunriseTime),
                  sunEventTime: getSunEventTime(sunriseTime, sunsetTime),
                  windSpeed: windSpeed,
                  humidity: humidity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
