import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:audiop/vivews/screen/audioscreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Models/global.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => CarouselApp(),
        "audio": (context) => Audio_Page(),
      },
    ),
  );
}

class CarouselApp extends StatefulWidget {
  const CarouselApp({super.key});

  @override
  State<CarouselApp> createState() => _CarouselAppState();
}

class _CarouselAppState extends State<CarouselApp> {
  int curreentpage = 0;
  bool isvertical = false;
  late AssetsAudioPlayer assetsAudioPlayer;


  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...Globals.arijit
              .map((e) => GestureDetector(
            onTap: (() {
              Globals.i = Globals.arijit.indexOf(e);
              Navigator.pushNamed(context, "audio", arguments: e);
            }),
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: e["color"]),
              height: 130,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(e["image"]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          e["name"],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          e["artist"],
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      // onTap: ,
                        child: Icon(Icons.play_arrow)),
                  ]),
            ),
          ))
              .toList(),
        ]),
      ),
    );
  }
}