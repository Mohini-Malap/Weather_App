import 'dart:math';
import 'package:flutter/material.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  bool hasData = false;
  String city = '';
  double temperature = 0.0;
  int humidity = 0;
  double windSpeed = 0.0;
  String description = '';

  final List<String> weatherConditions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Stormy',
    'Windy',
    'Snowy',
    'Foggy',
    'Overcast',
  ];

  void generateWeather(String cityName) {
    final random = Random();
    setState(() {
      city = cityName;
      temperature = 10 + random.nextInt(25) + random.nextDouble(); // 10–35°C
      humidity = 30 + random.nextInt(70); // 30–100%
      windSpeed = 0.5 + random.nextDouble() * 10; // 0.5–10.5 m/s
      description = weatherConditions[random.nextInt(weatherConditions.length)];
      hasData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      generateWeather(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (hasData)
              Expanded(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          city,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          description.toUpperCase(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _weatherDetail(Icons.water_drop, 'Humidity',
                                '$humidity%'),
                            _weatherDetail(Icons.air, 'Wind',
                                '${windSpeed.toStringAsFixed(1)} m/s'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    'Enter a city name to generate weather data',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _weatherDetail(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
