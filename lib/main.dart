import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_app/Widgets/favouriteList.dart';
import 'package:tinder_app/Widgets/profileSlide.dart';
import 'package:tinder_app/blocs/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idigo Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Idigo Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> bottomBars = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(
        'Home',
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(
        'Friends',
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) =>
            ProfileBloc(httpClient: http.Client())..add(FetchProfiles()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is ProfileUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileError) {
              return Center(
                child: Text('failed to fetch profiles'),
              );
            }
            if (state is ProfileLoaded) {
              if (state.profiles.isEmpty) {
                return Center(
                  child: Text('no profiles'),
                );
              }
              return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  activeColor: Colors.green,
                  backgroundColor: Colors.white,
                  inactiveColor: Colors.grey,
                  items: bottomBars,
                  iconSize: 21,
                ),
                tabBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Stack(
                        children: <Widget>[
                          Container(
                            color: Colors.black87,
                            height: 120,
                          ),
                          Container(
                            height: 340,
                            margin: EdgeInsets.only(
                              top: 30,
                            ),
                            child:
                                ProfileSlide(state.profiles, state.swipetype),
                          )
                        ],
                      );
                      break;
                    case 1:
                      return FavouriteList(state.favouriteProfiles);
                      break;
                  }
                  return null;
                },
              );
            }
          },
        ),
      ),
    );
  }
}
