import 'package:flutter/material.dart';
import 'dart:async';

import 'package:parkmanagercorp/screens/dashboard.dart';
import 'package:parkmanagercorp/screens/login.dart';
import 'package:parkmanagercorp/storage/sharedPreferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startime();
  }

  Future<bool> shouldGoToApp() async{
    String? token = null ;//await SharedPreferenceClass.getToken();
    if( token == null) return false;

    return true;
  }

  startime() {
    var duration = Duration(
        seconds: 5
    );
    return Timer(duration, route);
  }
  Future<void> route() async {
    bool shouldGo = await shouldGoToApp();
    if(shouldGo){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DashboardPage()));
    }
    else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginAppPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/park.png')
                  )
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: MediaQuery.of(context).size.width/8,
            child: Center(
              child: Container(
                child: Text(""),
              ),
            ),
          )
        ],
      ),
    );;
  }
}
