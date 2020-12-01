import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqarapp/helpers/Preferences.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/ui/ChosseUser.dart';
import 'package:waqarapp/ui/HomeScreen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => user.Id==null?ChooseUser():HomeScreen() //ChooseUser()//HomeScreen()
    ));
  }

UserVM user;
  @override
  void initState() {
    restore();
    super.initState();
    getUser().then((u) {
      setState(() {
        user=u;
        print("User Data");
        print(user.Id);
      });
      
      });
    startTime();
  }




  restore() async {
    final SharedPreferences Prefs = await SharedPreferences.getInstance();
    setState(() {
      // if(Prefs.getString('id')!= null){
      //   if(Prefs.getString('usertype')=="مستخدم")
      //   Preferences().setisuser(1);
      //   else Preferences().setisuser(2);
      // }
    });
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: transparent,
      body: Stack(

        alignment: Alignment.center,

        children: <Widget>[
          Image.asset(
            "images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                    'images/Logo-02.png',//'images/ic_launcher.png',
                    height: 160,
                    alignment: Alignment.center,
                ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 0),
                    child: Text(
                      " ",//"وسيط عقاري",
                      textAlign: TextAlign.center,
                      style: AqarFont.getLightFont_TextFormFieldtextheader(),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          ],
          ),
    );
  }
}
