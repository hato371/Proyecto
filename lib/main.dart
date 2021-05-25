import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fasty/LoginPage.dart';
import 'package:flutter_fasty/values/colors.dart';
//import 'package:flutter_2/FirstPage.dart';
//import 'package:flutter_2/OnBoardingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FirstPage.dart';
//import 'package:flutter_2/pages/DownloadPage.dart';

//import 'SplashScreenPage.dart';

/*void main() => runApp(MyRootApp(

)
);*/
Future<void> main() async {
  String initialRoute;

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString("usuario");
  if(token?.isEmpty ?? true){
    initialRoute =  '/Login';
  }else{
    initialRoute = '/FirstPage';
  }
  Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    routes: {
      '/FirstPage': (BuildContext context) => LoginPage(),
      // When navigating to the "/" route, build the FirstScreen widget.
      '/Login': (BuildContext context) => LoginPage(),
      // When navigating to the "/second" route, build the SecondScreen widget.

    },
  );
  runApp(app);
}

/*class MyRootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}*/

/*class MyRootApp extends StatelessWidget {

  //_iniciar();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            //home: Scaffold(body: Center(child: Text('App loaded'))),
            home: Splash(),
          );
        }
      },
    );
  }
}*/

/*Future<void> _iniciar() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.get("usuario"??'user');
  //preferences.setString("usuario", nombre);
  setState(() {
    username = preferences.get("usuario"??'user');
    //email = preferences.get("email" ?? 'email');
  });
  if(username!=null){
    // Navigator.of(context).pushReplacementNamed();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FirstPage()));
  }
  print("users");
  print(username);
}

void setState(Null Function() param0) {
}*/


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colores().color[0]),
      body: Center(

        child: Container(
          child: Image.asset("assets/images/isotipo.png", width: MediaQuery.of(context).size.width * 0.785,),
        ),
        /*child: Image(
          Image.asset(name),
          size: MediaQuery.of(context).size.width * 0.785,
        ),*/
      ),
    );
  }
}



/*void main() => runApp(MyRootApp());

class MyRootApp extends StatefulWidget  {
  @override
  _MyRootAppState createState() => _MyRootAppState();

}

class _MyRootAppState extends State<MyRootApp> {
  String username='';
  // This widget is the root of your application.
  @override
  void initState(){
    super.initState();
    _iniciar();
  }
@override
void dispose() {
  super.dispose();

}
  Future<void> _iniciar() async {
    int _start=0;
    //_validar();
    const oneSec = const Duration(milliseconds: 3000);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {

        if (_start == 100) {
          setState(() {
            timer.cancel();
            //_controller.reverse();
            int _start=0;
            //_validar();
            print("ahroa");
            //crear();
            Navigator.of(context).pop();
            //_send(code);
            showDialog(
              context: context,
              builder: (BuildContext context) => LoginPage(),
            );
          });
        }else{
          _start+=100;
        }
      },
    );
//crear();
  }
  crear() async {
    //void _tapUp(TapUpDetails details) {
      /*int _start=0;
      //_validar();
      const oneSec = const Duration(milliseconds: 100);
      Timer _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {

          if (_start == 100) {
            setState(() {
              timer.cancel();
              //_controller.reverse();
              int _start=0;
              //_validar();
              print("ahroa");
            });
          }else{
            _start+=100;
          }
        },
      );*/

    //}
    SharedPreferences preferences = await SharedPreferences.getInstance();

    username = preferences.get("usuario" ?? 'user');
    //preferences.setString("usuario", nombre);
    setState(() {
      username = preferences.get("usuario" ?? 'user');
      //email = preferences.get("email" ?? 'email');
    });
    if (username != null) {
      // Navigator.of(context).pushReplacementNamed();
      Navigator.of(context).pop();
      //_send(code);
      showDialog(
          context: context,
          builder: (BuildContext context) => FirstPage(),);
    }else{
      /*Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));*/
      Navigator.of(context).pop();
      //_send(code);
      showDialog(
        context: context,
        builder: (BuildContext context) => LoginPage(),
      );
    }
    print("users");
    print(username);
  }
  @override
  Widget build(BuildContext context) {
    //var media = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primarySwatch: Colors.blue),
      //home: LoginPage(),
      home: Scaffold(
        body: Container(
        //width: media.width,
        //height: media.height,
        color: Color(Colores().color[0]),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(88),
                    //height: MediaQuery.of(context).size.height,
                    //width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/isotipo.png", fit: BoxFit.fitWidth)

                    /*Stack(
                      children: [
                        Container(),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset("assets/images/isotipo.png", fit: BoxFit.cover,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),*/
                  ))
            ],
          ),
          //child: Image.asset("assets/images/isotipo.png"),
      ),
    )
    );
  }
}*/