import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainStateMusicPlay extends StatelessWidget {
  final music;

  const MainStateMusicPlay({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80),
          height: 300,
          width: 300,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(music.album.coverXl, fit: BoxFit.cover)),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(music.title,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 25),
              child: Text(music.artist.name,
                  style: TextStyle(color: Colors.grey, fontSize: 15)),
            )
          ],
        ),
        Button(music)
      ],
    );
  }
}

class Button extends StatefulWidget {
  final music;

  const Button(this.music, {Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState(music: music);
}

class _ButtonState extends State<Button> {
  final music;
  AudioPlayer audioPlayer = AudioPlayer();
  var icon = Icon(Icons.play_arrow, size: 40);
  var play = false;

  _ButtonState({this.music});

  Duration totalDuration = new Duration();
  Duration position = new Duration();

  initAudio() {
    audioPlayer.play(music.preview.toString());
    audioPlayer.onDurationChanged.listen((updateDuration) {
      setState(() {
        totalDuration = updateDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
    });
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            position.toString().split(".").first.split(":")[1] +
                ":" +
                position.toString().split(".").first.split(":")[2] +
                "/" +
                totalDuration.toString().split(".").first.split(":")[1] +
                ":" +
                totalDuration.toString().split(".").first.split(":")[2],
            style: TextStyle(color: Colors.grey)),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: MaterialButton(
            color: Colors.grey,
            onPressed: () {
              setState(() {
                if (play) {
                  pauseAudio();
                  icon = Icon(Icons.play_arrow, size: 40);
                  play = false;
                } else {
                  initAudio();
                  icon = Icon(Icons.pause, size: 40);
                  play = true;
                }
              });
            },
            child: icon,
            padding: EdgeInsets.all(5),
            shape: CircleBorder(),
          ),
        )
      ],
    );
  }
}
