import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fasty/Admi/RegistrarUsuarios.dart';
import 'package:flutter_fasty/FadeAnimation.dart';
import 'package:flutter_fasty/Venta.dart';
import 'dart:math' as math;
import 'package:flutter_fasty/values/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class Usuarios extends StatefulWidget {
  @override
  _Usuarios createState() => _Usuarios();
}

class _Usuarios extends State<Usuarios> {
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
  int cantidadempleados;

  var empleados = new List();
  var nivel = new List();
  var foto = new List();
  File _imagen;
  @override
  void initState() {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    obtenerPreferencias();
    _leer();
  }

   final nombres = [
    'LeccionesPage',
    'UserPage',
    'UserPage',
    'SettingsPage',
    'SettingsPage'
  ];

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      //contador = preferences.get("leccion")??"0.0";
      //color =preferences.get("color")??0xff04092b;
      //barcolor =preferences.get("barcolor")??0xff264b99;
      //lvcolor =preferences.get("lvcolor")??0xff1b3280;
      //btncolor=preferences.get("btncolor")??0xfff4f4f4;
      //letracolor =preferences.get("letracolor")??0xff010612;
      tipo = preferences.get("tipo") ?? 0;
      selectedIndex = preferences.get("indice") ?? 0;
    });
  }

  Future<List> _leer() async {
    int valor;
    print("Vaaaaaaaaaaal");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http
        .post("http://lapalomaburger.000webhostapp.com/leerempleados.php", body: {
    });

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);
    print(_data.length);
    setState(() {

      cantidadempleados = _data.length;
      //cantidadtiendas = valor;
      print("Cantidad $cantidadempleados");
      //preferences.setInt("cantidadtiendas", cantidadtiendas);
      empleados.clear();
      nivel.clear();
      foto.clear();
      setState(() {
        for(int i=0; i<cantidadempleados; i++){
          empleados.add("${_data[i]["username"]}");
          nivel.add("${_data[i]["nivel"]}");
          foto.add("${_data[i]["imagen"]}");
        }
      });

    });

  }

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
        appBar: new AppBar(
//          backgroundColor: Color(Colores().color[0]),
          backgroundColor: Color(Colores().pruebacolor[0]),
          leading:
            IconButton(
                //iconSize: ((media.height/)),
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: (((w + h) * .025)),
                ),
                onPressed: () => _nocambiar()),
          title: Center(
            child: Text(
              "Usuarios",
              style: TextStyle(
                //color: Color(Colores().pruebacolor[0]),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ((w + h) * .5) * .035),
            ),
          ),
        ),

        body: Container(
          color:  Color(0xff858585).withOpacity(.15),
          width: w,
          height: h,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  //scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 50),
                    itemCount: empleados.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            height: ((w+h)*.5)*.225,
                            width: w*.9,
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                AnimatedButton(
                                    height: ((w + h) * .5) * .19,
                                    width: ((w + h) * .5) * .19,
                                    color: Colors.transparent,
                                    //height: 50,
                                    onPressed: null,
                                    child: foto[index] != ''
                                        ? CircleAvatar(
                                      radius: 120,
                                      //backgroundImage: FileImage(_imagen),
                                      backgroundImage: FileImage(File(foto[index])),
                                      //child: _setImageView(w, h),
                                    )
                                        : CircleAvatar(
                                      radius: 120,
                                      backgroundColor:
                                      Color(Colores().pruebacolor[0]),
                                      //backgroundImage: FileImage(imageFile),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.camera),
                                          Text("Imagen")
                                        ],
                                      ),
                                    )),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Usuario: ${empleados[index]}",
                                      style: TextStyle(
                                        //color: Color(Colores().pruebacolor[0]),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ((w + h) * .5) * .035),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tipo usuario: ${nivel[index]}",
                                      //"Tipo usuario ${index+1}",
                                      style: TextStyle(
                                        //color: Color(Colores().pruebacolor[0]),
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ((w + h) * .5) * .025),
                                    ),
                                  ],
                                ),
                               Expanded(child:  Column(
                                 mainAxisAlignment:
                                 MainAxisAlignment.start,
                                 children: [
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.end,
                                     children: [
                                       Container(
                                         //color: Colors.red,
                                         height: 30,
                                         child: PopupMenuButton<String>(
                                           onSelected: handleClick,
                                           itemBuilder: (BuildContext context) {
                                             return {'Editar', 'Eliminar'}.map((String choice) {
                                               return PopupMenuItem<String>(
                                                 value: choice,
                                                 child: Text(choice),
                                               );
                                             }).toList();
                                           },
                                         ),
                                       ),
                                     ],
                                   )
                                 ],
                               ))
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),

                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: AnimatedButton(
                  width: 300,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrarUsuarios())
                    );
                    //_validar();
                  },
                  child: Center(
                    child: Text(
                      "Agregar nuevo usuario",
                      style: TextStyle(
                        //color: Color(Colores().pruebacolor[0]),
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: ((w + h) * .5) * .035),
                    ),
                  ),
                  color: Color(Colores().pruebacolor[0]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),

        ),
        //body: ContactsPage()
      ),
    );
    //});
  }
  void handleClick(String value) {
    switch (value) {
      case 'Editar':
        break;
      case 'Eliminar':
        break;
    }
  }


  _nocambiar() {
    Navigator.of(context).pop();
  }
}
