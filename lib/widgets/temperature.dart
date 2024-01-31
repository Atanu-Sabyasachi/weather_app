import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    super.key,
    required this.temperature,
  });

  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          double.tryParse(temperature)?.toInt().toString() ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 80),
        ),
        const Text(
          "°C",
          style: TextStyle(fontSize: 80),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
