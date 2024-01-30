// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherInfoRow extends StatefulWidget {
  final IconData sunEventIcon;
  final String sunEventTitle;
  final String sunEventTime;
  final String windSpeed;
  final String humidity;

  const WeatherInfoRow({
    Key? key,
    required this.sunEventIcon,
    required this.sunEventTitle,
    required this.sunEventTime,
    required this.windSpeed,
    required this.humidity,
  }) : super(key: key);

  @override
  _WeatherInfoRowState createState() => _WeatherInfoRowState();
}

class _WeatherInfoRowState extends State<WeatherInfoRow> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              BoxedIcon(
                widget.sunEventIcon,
                size: 20,
              ),
              const SizedBox(height: 10),
              Text(widget.sunEventTitle),
              Text(
                widget.sunEventTime,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 20),
          const VerticalDivider(
            color: Colors.white,
            thickness: 0.5,
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const BoxedIcon(
                WeatherIcons.strong_wind,
                size: 20,
              ),
              const SizedBox(height: 10),
              const Text("WIND"),
              Text(
                widget.windSpeed,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 20),
          const VerticalDivider(
            color: Colors.white,
            thickness: 0.5,
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const BoxedIcon(
                WeatherIcons.humidity,
                size: 20,
              ),
              const SizedBox(height: 10),
              const Text("Humidity"),
              Text(
                widget.humidity,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
