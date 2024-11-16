import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(ClimaApp());
}

class ClimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima - Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _weatherData = 'Loading...';

  Future<void> fetchWeather() async {
    const String apiKey = 'bd5e378503939ddaee76f12ad7a97608';
    const String city = 'Hanoi';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _weatherData = 'Temperature in $city: ${data['main']['temp']}°C';
        });
      } else {
        setState(() {
          _weatherData = 'Error: Unable to fetch data';
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima - Weather App'),
      ),
      body: Center(
        child: Text(
          _weatherData,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
