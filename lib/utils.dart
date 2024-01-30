import 'package:flutter/material.dart';
import 'package:mobile_design/city_selection_dialog.dart';
import 'package:mobile_design/constants/cities.dart';
import 'package:weather_icons/weather_icons.dart';

String getGreetingMessage(DateTime dateTime) {
  int hour = dateTime.hour;

  if (hour >= 6 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 22) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

Future<Iterable<String>> onSuggestionCallback(String value) async {
  if (value.isNotEmpty) {
    return cities
        .where((city) => city.toLowerCase().contains(value.toLowerCase()))
        .toList();
  } else {
    return [];
  }
}

IconData getSunEventIcon(String sunriseTime) {
  DateTime now = DateTime.now();
  DateTime sunrise = DateTime.tryParse(sunriseTime) ?? DateTime(0);
  return now.isBefore(sunrise) ? WeatherIcons.sunrise : WeatherIcons.sunset;
}

String getSunEventTitle(String sunriseTime) {
  DateTime now = DateTime.now();
  DateTime sunrise = DateTime.tryParse(sunriseTime) ?? DateTime(0);
  return now.isBefore(sunrise) ? "SUNRISE" : "SUNSET";
}

String getSunEventTime(String sunriseTime, String sunsetTime) {
  DateTime now = DateTime.now();
  DateTime sunrise = DateTime.tryParse(sunriseTime) ?? DateTime(0);
  return now.isBefore(sunrise) ? "$sunriseTime AM" : "$sunsetTime PM";
}

Future<String?> showCityDialog(
    BuildContext context, TextEditingController cityController) async {
  String? selectedCity;
  await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return CitySelectionDialog(
        cityController: cityController,
        onSuggestionCallback: onSuggestionCallback,
        onSuggestionSelected: (city) async {
          selectedCity = city.toString();
        },
        onPopInvoked: (value) {
          if (value == true) cityController.clear();
        },
      );
    },
  );
  return selectedCity;
}
