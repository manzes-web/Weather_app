import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/home_screen/fetchdata.dart';
import 'package:weather_app/home_screen/weather.dart';
import 'package:weather_app/splash_screen/help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const locationkey = 'location';
  final storage = GetStorage();
  late final TextEditingController inputtextcontroller;
  bool isempty = true;

  @override
  void initState() {
    super.initState();
    final locationName = storage.read<String>(locationkey);
    inputtextcontroller = TextEditingController(text: locationName);
    inputtextcontroller.addListener(listenTextField);
  }

  void listenTextField() {
    if (inputtextcontroller.text.isEmpty) {
      isempty = true;
    } else {
      isempty = false;
    }
    setState(() {});
  }

  final _weatherService = FetchData();

  Weather? _weather;
  WeatherError? error;
  bool isLoading = false;

  Future<void> _fetchWeather() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
      error = null;
      _weather = null;
    });
    try {
      final weather =
          await _weatherService.getWeatherByCity(inputtextcontroller.text);

      setState(() {
        _weather = weather;
        isLoading = false;
      });
    } catch (e) {
      if (e is WeatherError) {
        setState(() {
          error = e;
          isLoading = false;
        });
      }
    }
    await storage.write(locationkey, inputtextcontroller.text);
  }

  @override
  void dispose() {
    inputtextcontroller.dispose();
    inputtextcontroller.removeListener(listenTextField);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: const Text(
            'Weather App',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpScreen()));
                },
                icon: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Text(
                      'back',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            if (_weather != null)
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue.shade100,
                child: Column(
                  children: [
                    Image.network('https:${_weather!.icon}'),
                    Text(
                      '${_weather!.city}, ${_weather!.country}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text('${_weather!.temperature.toString()}°C',
                        style: const TextStyle(fontSize: 20)),
                    Text(_weather!.text, style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            if (error != null) Text(error!.error),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: inputtextcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter name of place',
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _fetchWeather();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                  minimumSize: const Size(200, 50)),
              child: Text(
                isempty ? 'SAVE' : 'UPDATE',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
