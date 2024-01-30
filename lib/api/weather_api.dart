// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class WeatherApi {
//   final String apiKey;
//   final String baseUrl;

//   WeatherApi(this.apiKey, this.baseUrl);

//   Future<Map<String, dynamic>> getWeather(String city) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }



// import 'dart:convert';
// import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';

// class WeatherApi {
//   final String apiKey;
//   final String baseUrl;

//   WeatherApi(
//     this.apiKey,
//     this.baseUrl,
//   );

//   Future<Map<String, dynamic>> getWeatherByCity(String city) async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey'));
//     return _processResponse(response);
//   }

//   Future<Map<String, dynamic>> getWeatherByLocation() async {
//     LocationData? locationData = await _getLocation();

//     if (locationData != null) {
//       final response = await http.get(Uri.parse(
//           '$baseUrl/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey'));
//       return _processResponse(response);
//     } else {
//       throw Exception('Failed to get location');
//     }
//   }

//   Future<LocationData?> _getLocation() async {
//     Location location = Location();

//     try {
//       return await location.getLocation();
//     } catch (e) {
//       print('Error getting location: $e');
//       return null;
//     }
//   }

//   Future<String> getCurrentCity() async {
//     LocationData? locationData = await _getLocation();

//     if (locationData != null) {
//       try {
//         List<geocoding.Placemark> placemarks =
//             await geocoding.placemarkFromCoordinates(
//           locationData.latitude!,
//           locationData.longitude!,
//         );

//         if (placemarks.isNotEmpty) {
//           return placemarks.first.locality ?? 'Unknown City';
//         } else {
//           return 'Unknown City';
//         }
//       } catch (e) {
//         print('Error getting city name: $e');
//         return 'Unknown City';
//       }
//     } else {
//       return 'Unknown City';
//     }
//   }

//   Map<String, dynamic> _processResponse(http.Response response) {
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }
