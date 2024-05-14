import 'dart:async';

import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/weather_background.png'),
                    fit: BoxFit.fill))),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'WE SHOW WEATHER\n FOR YOU!',
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
              ),
              SizedBox(
                width: 120,
                height: 50,
                child: OutlinedButton(
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Row(
                      children: [
                        Text(
                          'SKIP',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
