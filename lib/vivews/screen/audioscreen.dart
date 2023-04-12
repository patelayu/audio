import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../../Models/global.dart';


class Audio_Page extends StatefulWidget {
  const Audio_Page({super.key});

  @override
  State<Audio_Page> createState() => _Audio_PageState();
}

class _Audio_PageState extends State<Audio_Page> {
  bool isplaying = false;
  Duration? totalduration;
  int a = 0;
  playaudio() async {
    await Globals.assetsAudioPlayer.open(
      Audio("${Globals.arijit[Globals.i]['song']}"),
    );

    setState(() {
      isplaying = true;
      totalduration = Globals.assetsAudioPlayer.current.value!.audio.duration;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playaudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Globals.arijit[Globals.i]["name"]),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Globals.arijit[Globals.i]["color"],
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Container(
            height: 300,
            width: 400,
            child: Image.asset(Globals.arijit[Globals.i]["image"]),
          ),
          StreamBuilder(
            stream: Globals.assetsAudioPlayer.currentPosition,
            builder: (context, AsyncSnapshot<Duration> snapshot) {
              Duration? currentPosition = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    // activeColor:Globals.playsong["color"],
                    value: (currentPosition != null)
                        ? currentPosition.inSeconds.toDouble()
                        : 0,
                    onChanged: (val) async {
                      await Globals.assetsAudioPlayer
                          .seek(Duration(seconds: val.toInt()));
                    },
                    min: 0,
                    max: (Globals.assetsAudioPlayer.current.value != null)
                        ? totalduration!.inSeconds.toDouble()
                        : 0.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${currentPosition.toString().split(".")[0]}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "${Globals.assetsAudioPlayer.current.value?.audio.duration.toString().split('.')[0]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Globals.assetsAudioPlayer.updateCurrentAudioNotification(
                    metas: Metas(
                      artist: Globals.arijit[Globals.i]["artist"],
                      image: MetasImage.asset(
                          Globals.arijit[Globals.i]["image"]),
                      title: Globals.arijit[Globals.i]["name"],
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Icon(
                    Icons.volume_up_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black),
                child: GestureDetector(
                  onTap: () {
                    if (isplaying == true) {
                      setState(() {
                        isplaying = false;
                      });
                      Globals.assetsAudioPlayer.pause();
                    } else {
                      setState(() {
                        isplaying = true;
                      });
                      Globals.assetsAudioPlayer.play();
                    }
                  },
                  child: Icon(
                    (isplaying == true) ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Globals.assetsAudioPlayer.stop();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}