import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home_screen/home_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool _ispressed = false;
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    print(_ispressed);
    if (_ispressed != true) {
      await Future.delayed(Duration(seconds: 5), () {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/weather_background.png'),
                    fit: BoxFit.fill))),
        // Center(
        //   child: Image.asset(
        //     'lib/assets/frame.png', // Replace with your frame image path
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'WE SHOW YOU WEATHER HERE!',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                width: 120,
                height: 50,
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _ispressed = true;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Row(
                      children: [
                        Text(
                          'skip',
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
