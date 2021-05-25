import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fasty/Admi/RegistrarTienda.dart';
import 'package:flutter_fasty/Admi/tienda.dart';
import 'package:flutter_fasty/Venta.dart';
import 'dart:math' as math;
import 'package:flutter_fasty/values/colors.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}*/

class FirstPageAdmi extends StatefulWidget {
  @override
  _FirstPageAdmi createState() => _FirstPageAdmi();
}

class _FirstPageAdmi extends State<FirstPageAdmi> {
  //obtenerPreferencias();
  int color = 0xff264b99;
  int barcolor = 0xff264b99;
  //1a2a44
  int lvcolor = 0xff1b3280;
  int btncolor = 0xfff4f4f4;
  int letracolor = 0xff010612;
  int selectedIndex = 0;
  int tipo = 0;
  var col = [ShadowDegree.dark, ShadowDegree.light];
  int cantidadtiendas;

  var respi = new List();
  var index = 0;
  var imageFile;
  String imagen;
  @override
  void initState() {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _leer();
    obtenerPreferencias();
    //tiendas();

  }

  final List<Widget> children = [
    /*LeccionesPage(),
    UserPage(),
    SettingsPage(),*/
  ];

  final List<String> imgList = [
    'Tienda 1',
    'Tienda 2',
    'Tienda 3'
    //'assets/images/letraa.mp4',
    //'assets/images/letraa.mp4',
  ];


  Future<List> _leer() async {
    int valor;
    print("Vaaaaaaaaaaal");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http
        .post("http://lapalomaburger.000webhostapp.com/tienda.php", body: {
    });

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);
    print(_data.length);
    setState(() {

      cantidadtiendas = _data.length;
      //cantidadtiendas = valor;
      print("Cantidad $cantidadtiendas");
      //preferences.setInt("cantidadtiendas", cantidadtiendas);
      respi.clear();
      setState(() {
        for(int i=0; i<cantidadtiendas; i++){
          respi.add("Tienda ${i+1}");
        }
      });

    });

  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      //imageFile = File(null);
      imagen = preferences.getString("imagen");
      print("Imageeeeeeeeeeen $imagen");
      //imageFile = File(imagen);

      //cantidadtiendas = preferences.getInt("cantidadtiendas")??0;
      //color =preferences.get("color")??0xff04092b;
      //barcolor =preferences.get("barcolor")??0xff264b99;
      //lvcolor =preferences.get("lvcolor")??0xff1b3280;
      //btncolor=preferences.get("btncolor")??0xfff4f4f4;
      //letracolor =preferences.get("letracolor")??0xff010612;
      tipo = preferences.get("tipo") ?? 0;
      selectedIndex = preferences.get("indice") ?? 0;
    });
  }

  /*void tiendas(){
    respi.clear();
    setState(() {
      for(int i=0; i<cantidadtiendas; i++){
        respi.add("Tienda ${i+1}");
      }
    });

  }*/

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    /*return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          brightness: brightness,
          //rest of the themeData
          //you can also use conditioning here based on the current
          //brightness mode (dark or light). For ex:
          // primarySwatch: brightness == Brighness.dark ? Colors.white : Colors.black
        ),*/
    // themedWidgetBuilder: (context, theme) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Exam Prep',
      //theme: theme,
      //color: Colors.red,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                "¡Bienvenido!",
                style: TextStyle(
                    //color: Color(Colores().pruebacolor[0]),
                    color: Color(0xffd67700),
                    fontWeight: FontWeight.bold,
                    fontSize: ((w + h) * .5) * .035),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: respi.map((url) {
                    int z = respi.indexOf(url);
                    return Row(
                      children: [
                        AnimatedButton(
                          height: ((w + h) * .5) * .2,
                          width: ((w + h) * .5) * .2,
                          color: Colors.transparent,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => tienda()), //MaterialPageRoute
                            );
                          },
                          child: Container(
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(Colores().btncolor[tipo]),
                                //color: const Color(0xFFFFFF),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black, spreadRadius: 3),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Transform(
                                          transform: Matrix4.rotationY(0),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            CupertinoIcons.home,
                                            size: ((w + h) * .5) * .1,
                                            color:
                                                Color(Colores().pruebacolor[0]),
                                          ))

                                      // color: Colors.green,
                                      ),
                                  Center(
                                    // child: Visibility(
                                    child: Text(
                                      "${respi[z]}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: ((w + h) * .5) * .035),
                                    ),
                                    //visible: a3,
                                    // ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    );
                  }).toList(),
                ),
                AnimatedButton(
                  height: ((w + h) * .5) * .2,
                  width: ((w + h) * .5) * .2,
                  color: Colors.transparent,
                  onPressed:(){
                    //tiendas();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrarTienda()), //MaterialPageRoute
                    );
                  },
                  child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(Colores().btncolor[tipo]),
                        //color: const Color(0xFFFFFF),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Transform(
                                  transform: Matrix4.rotationY(0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    CupertinoIcons.plus_circle,
                                    size: ((w + h) * .5) * .1,
                                    color: Color(Colores().pruebacolor[0]),
                                  ))

                              // color: Colors.green,
                              ),
                          Center(
                            // child: Visibility(
                            child: Text(
                              "Agregar",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .035),
                            ),
                            //visible: a3,
                            // ),
                          ),
                        ],
                      )),
                ),
                /*Container(
                  width: 150,
                  height: 150,
                  child:  Image.file(File(imagen)),
                )*/

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedButton(
                    onPressed: null,
                    color: Colors.transparent,
                    child: Container(
                      //color: Colors.green,
                      child: Center(
                        // child: Visibility(
                        child: Text(
                          "Cerrar sesión",
                          style: TextStyle(
                              color: Color(Colores().pruebacolor[tipo]),
                              fontWeight: FontWeight.normal,
                              fontSize: ((w + h) * .5) * .035),
                        ),
                        //visible: a3,
                        // ),
                      ),
                    ))
              ],
            )
          ],
        ),
        //body: ContactsPage()
      ),
    );
    //});
  }
}
