import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer? audioPlayer;
  String duration = "00:00:00";

  _MyAppState() {
    audioPlayer = AudioPlayer();  
    audioPlayer?.onAudioPositionChanged.listen((drs) {
      setState(() {
        duration = drs.toString();
      });
    });
    audioPlayer?.setReleaseMode(ReleaseMode.LOOP);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Music Player"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await audioPlayer?.play("https://luan.xyz/files/audio/ambient_c_motion.mp3");
                }, 
                child: const Text("Play")
              ),
              ElevatedButton(
                onPressed: () async {
                  await audioPlayer?.pause();
                }, 
                child: const Text("Pause")
              ),
              ElevatedButton(
                onPressed: () async {
                  await audioPlayer?.stop();
                  setState(() {
                    duration = "00:00:00";
                  });
                },
                child: const Text("Stop")
              ),
              ElevatedButton(
                onPressed: () async {
                  await audioPlayer?.resume();
                },
                child: const Text("Resume")
              ),
              Text(duration)
            ],
          ),
        ),
      ),
    );
  }
}