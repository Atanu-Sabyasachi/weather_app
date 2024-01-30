import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIconHelper {
  static BoxedIcon getTemperatureIcon(
      double? temp, String weatherMain, String weatherDescription) {
    if (weatherMain.contains('rain') || weatherDescription.contains('rain')) {
      if (weatherDescription.contains('drizzle')) {
        return _getRainIcon(WeatherIcons.raindrops);
      } else if (weatherDescription.contains('light rain')) {
        return _getRainIcon(WeatherIcons.rain);
      } else if (weatherDescription.contains('heavy rain')) {
        return _getRainIcon(WeatherIcons.rain_mix);
      } else {
        return _getRainIcon(WeatherIcons.rain);
      }
    } else {
      return _getTemperatureIcon(temp);
    }
  }

  static BoxedIcon _getTemperatureIcon(double? temp) {
    IconData icon = WeatherIcons.horizon_alt;
    Color color = Colors.green;

    if (temp != null) {
      if (temp < 0) {
        icon = WeatherIcons.snowflake_cold;
        color = Colors.white;
      } else if (temp < 5) {
        icon = WeatherIcons.snow;
        color = Colors.white;
      } else if (temp < 10) {
        icon = WeatherIcons.day_snow;
        color = Colors.white;
      } else if (temp < 15) {
        icon = WeatherIcons.cloud;
        color = Colors.grey;
      } else if (temp < 20) {
        icon = WeatherIcons.night_partly_cloudy;
        color = Colors.lightBlueAccent;
      } else if (temp < 25) {
        icon = WeatherIcons.cloud_up;
        color = Colors.orange;
      } else if (temp < 30) {
        icon = WeatherIcons.day_sunny;
        color = Colors.orange;
      } else if (temp < 35) {
        icon = WeatherIcons.hot;
        color = Colors.orange;
      } else if (temp < 40) {
        icon = WeatherIcons.day_sunny_overcast;
        color = Colors.orange;
      } else {
        icon = WeatherIcons.hot;
        color = Colors.orange;
      }
    }

    return BoxedIcon(
      icon,
      color: color,
      size: 100,
    );
  }

  static BoxedIcon _getRainIcon(IconData icon) {
    return BoxedIcon(
      icon,
      color: Colors.white,
      size: 100,
    );
  }
}
