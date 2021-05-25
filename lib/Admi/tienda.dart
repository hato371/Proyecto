import 'package:animated_button/animated_button.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fasty/Admi/Inventario.dart';
import 'package:flutter_fasty/Admi/Productos.dart';
import 'package:flutter_fasty/Admi/usuarios.dart';
import 'package:flutter_fasty/Venta.dart';
import 'dart:math' as math;
import 'package:flutter_fasty/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class tienda extends StatefulWidget {
  @override
  _tienda createState() => _tienda();
}

class _tienda extends State<tienda> {
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
  @override
  void initState() {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    obtenerPreferencias();
  }

  final List<Widget> children = [
    /*LeccionesPage(),
    UserPage(),
    SettingsPage(),*/
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
        body: ListView(
          children: [
            Center(
              child: Text(
                "Tienda 1",
                style: TextStyle(
                  //color: Color(Colores().pruebacolor[0]),
                    color: Color(0xffd67700),
                    fontWeight: FontWeight.bold,
                    fontSize: ((w + h) * .5) * .035),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedButton(
                      height: ((w+h)*.5)*.14,
                      color: Colors.transparent,
                      onPressed: null,
                      child: Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(Colores().btncolor[tipo]),
                            //color: const Color(0xFFFFFF),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  child: Transform(transform: Matrix4.rotationY(3),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.clock,size: ((w+h)*.5)*.09,color: Colors.green,))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Abrir turno",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.14,
                      color: Colors.transparent,
                      onPressed: null,
                      child: Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(Colores().btncolor[tipo]),
                            //color: const Color(0xFFFFFF),
                            borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(color: Colors.red, spreadRadius: 3),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  child: Transform.rotate(angle: 180 * math.pi / 270,alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.clock,size: ((w+h)*.5)*.09,color: Colors.red,))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Cerrar turno",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed:() {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Venta()), //MaterialPageRoute
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
                                  //child: Transform(transform: Matrix4.rotationY(3),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.square_favorites,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),)

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Vender",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed: null,
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

                                      child: Icon(CupertinoIcons.bag_badge_plus,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),)

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Ordenes",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed: null,
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
                                  child: Transform(transform: Matrix4.rotationY(0),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.chat_bubble_text_fill,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Chat",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed:() {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Venta()), //MaterialPageRoute
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
                                  child: Transform(transform: Matrix4.rotationY(3),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.tray_arrow_down,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Cortes",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed:() {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Productos()), //MaterialPageRoute
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
                                  child: Transform(transform: Matrix4.rotationY(3),alignment: Alignment.center,
                                      child: Icon(Icons.fastfood_outlined,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Productos",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inventario()), //MaterialPageRoute
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
                                  child: Transform(transform: Matrix4.rotationY(0),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.text_badge_checkmark,size: ((w+h)*.5)*.1,color: Color(Colores().pruebacolor[0]),))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Inventario",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),
                    AnimatedButton(
                      height: ((w+h)*.5)*.17,
                      width: ((w+h)*.5)*.17,
                      color: Colors.transparent,
                      onPressed:() {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Usuarios()), //MaterialPageRoute
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
                                  child: Transform(transform: Matrix4.rotationY(3),alignment: Alignment.center,
                                      child: Icon(CupertinoIcons.person_solid,size: ((w+h)*.5)*.09,color: Color(Colores().pruebacolor[0]),))

                                // color: Colors.green,
                              ),
                              Center(
                                // child: Visibility(
                                child: Text(
                                  "Usuarios",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ((w + h) * .5) * .03),
                                ),
                                //visible: a3,
                                // ),
                              ),
                            ],
                          )
                      ),


                    ),

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
                        )
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        //body: ContactsPage()
      ),
    );
    //});
  }
}
