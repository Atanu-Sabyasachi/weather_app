import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    super.key,
    required this.cityName,
    required StreamController<DateTime> streamController,
  }) : _streamController = streamController;

  final String cityName;
  final StreamController<DateTime> _streamController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          cityName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        const SizedBox(height: 5),
        StreamBuilder<DateTime>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String formattedTime =
                  DateFormat('h:mm a').format(snapshot.data!);
              String dayOfWeek =
                  DateFormat('EEEE').format(snapshot.data!).toUpperCase();
              return Column(
                children: [
                  Text(dayOfWeek),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
