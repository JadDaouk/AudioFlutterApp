import 'package:flutter/material.dart';
import 'package:technical_test/services/MusicApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:technical_test/widgets/MainStateMusicPlay.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageBuilder(),
    );
  }
}

class HomePageBuilder extends StatefulWidget {
  const HomePageBuilder({Key? key}) : super(key: key);

  @override
  State<HomePageBuilder> createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, color: Colors.grey);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Musiques',
      style: optionStyle,
    ),
    Center(child: MusicDataBuider()),
    Text(
      'Multiroom',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
            "Ma musique",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )),
          backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_albums_fill),
            label: 'Musiques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Jouer',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_house_fill),
            label: 'Multiroom',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MusicDataBuider extends StatelessWidget {
  const MusicDataBuider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMusicsFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          else if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.grey)));
          else
            return MainStateMusicPlay(music: snapshot.data);
        });
  }
}
