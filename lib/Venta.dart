import 'package:animated_button/animated_button.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fasty/NavDrawer.dart';
import 'dart:math' as math;
import 'package:flutter_fasty/values/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
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

class Venta extends StatefulWidget {
  @override
  _Venta createState() => _Venta();
}

class _Venta extends State<Venta> {
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
  int count=0;
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
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Center(
            child: Text('Venta'),
          ),
          backgroundColor: Color(Colores().pruebacolor[tipo]),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  width: w * .745,
                  //height: 10,
                  //color: Colors.blueAccent,
                  child: Column(
                    children: [
                      Container(
                          height: 100,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              'MENÚ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: ((w+h)*.5)*.035,
                                color: Color(Colores().letracolorclaro[tipo]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                          height: 500,
                          //color: Colors.blueGrey,
                          child: Center(
                            child: ScrollNavigation(
                              bodyStyle: NavigationBodyStyle(
                                //background: Colors.white,
                                //borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                                scrollDirection: Axis.horizontal,
                              ),
                              barStyle: NavigationBarStyle(
                                position: NavigationPosition.top,
                                elevation: 1.0,
                                activeColor: Colors.black,
                                //deactiveColor: Colors.white,
                                background: Color(0xffffffff),
                              ),
                              pages: [
                                Container(
                                  //color: Colors.green[100],
                                  child: ListView(
                                    children: [
                                      Container(
                                        //padding: EdgeInsets.only(left: 50,right: 50),
                                        height: 5,
                                        //width: 10,
                                        color: Colors.black
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 150,
                                             //color: Colors.green,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Especial',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: ((w+h)*.5)*.025,
                                                        color: Color(Colores().letracolor[0]),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      AnimatedButton(
                                                        width: ((w+h)*.5)*.05,
                                                        height: ((w+h)*.5)*.05,
                                                        color: Colors.transparent,
                                                        onPressed:(){
                                                          if(count>1){
                                                            setState(() {
                                                              count--;
                                                            });
                                                          }


                                                        },
                                                        child: Container(
                                                            child: Icon(CupertinoIcons.minus_circle,size: ((w+h)*.5)*.05,color: Colors.red,)
                                                          // color: Colors.green,
                                                        ),

                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Text(
                                                            '${count}',
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              fontSize: ((w+h)*.5)*.025,
                                                              color: Color(Colores().letracolor[0]),
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      AnimatedButton(
                                                        width: ((w+h)*.5)*.05,
                                                        height: ((w+h)*.5)*.05,
//                                                        color: Colors.blue,
                                                        color: Colors.transparent,
                                                        onPressed:(){
                                                          setState(() {
                                                            count++;
                                                          });
                                                        },
                                                        child: Container(
                                                            child: Icon(CupertinoIcons.plus_circle,size: ((w+h)*.5)*.05,color: Colors.green,)
                                                          // color: Colors.green,
                                                        ),

                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              width: 100,
                                              //color: Colors.green,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'MXN 55.00',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: ((w+h)*.5)*.02,
                                                        color: Color(Colores().letracolor[0]),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height:((w+h)*.5)*.07,
                                              width:  ((w+h)*.5)*.25,
                                              //color: Colors.green,
                                              child: Column(
                                                children: [
                                                  AnimatedButton(
                                                    width: ((w+h)*.5)*.25,
                                                    height: ((w+h)*.5)*.07,
                                                    color: Colors.grey,
                                                    onPressed:(){
                                                      if(count>1){
                                                        setState(() {
                                                          count--;
                                                        });
                                                      }


                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Center(
                                                        child: Text(
                                                          'Agregar nota (salsa adicional, sin cebolla, etc)',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: ((w+h)*.5)*.02,
                                                            color: Color(Colores().letracolor[1]),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                              height:((w+h)*.5)*.07,
                                              width:  ((w+h)*.5)*.1,
                                              //color: Colors.green,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AnimatedButton(
                                                      width: ((w+h)*.5)*.1,
                                                      height: ((w+h)*.5)*.05,
                                                      color: Color(0xff00ec00),
                                                      onPressed:(){
                                                        if(count>1){
                                                          setState(() {
                                                            count--;
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Text(
                                                            'Agregar',
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: ((w+h)*.5)*.02,
                                                              color: Color(Colores().letracolor[0]),
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        //padding: EdgeInsets.only(left: 50,right: 50),
                                          height: 5,
                                          //width: 10,
                                          color: Colors.black
                                      ),
                                    ],
                                  ),
                                ),
                                Container(color: Colors.green[100]),
                                Container(color: Colors.green[100]),
                                Container(color: Colors.green[100]),
                              ],
                              items: const [
                                ScrollNavigationItem(icon: Icon(Icons.search,size: .001,),title: "Hamburgresas"),
                                ScrollNavigationItem(icon: Icon(Icons.search,size: .001,),title: "Boneless"),
                                ScrollNavigationItem(icon: Icon(Icons.search,size: .001,),title: "Alitas"),
                                ScrollNavigationItem(icon: Icon(Icons.search,size: .001,),title: "Papas asadas"),
                              ],
                            )
                          )
                      )
                    ],
                  ),
                ))
              ],
            ),
            Expanded(
              child: Container(
                width: w * .010,
                //height: 10,
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Expanded(
                    child: Container(
                  width: w * .245,
                  //height: 10,
                  color: Colors.white,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Icon(
                              FontAwesomeIcons.solidUserCircle,
                              size: 100,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: (w+h)*.01,
                          ),
                          Center(
                            child: Text(
                              'Iván Palomo',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: ((w+h)*.5)*.025,
                                color: Color(Colores().letracolor[tipo]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Color(Colores().btncolor[tipo]),
                                  //color: const Color(0xFFFFFF),
                                  borderRadius:
                                  new BorderRadius.all(new Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(color: Color(0xff4f4d4e), spreadRadius: 3),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      //color: Colors.greenAccent,
                                      height: h*.45,
                                      width: w*.225,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'PDD: 8',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: ((w+h)*.5)*.025,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    'TEE: 40 min',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: ((w+h)*.5)*.025,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ]
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xff4f4d4e),
                                      height: h*.1,
                                      width: w*.225,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'Total: $count',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: ((w+h)*.5)*.025,
                                                color: Color(Colores().letracolor[1]),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h*.01,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Color(Colores().btncolor[0]),
                                                  //color: const Color(0xFFFFFF),
                                                  borderRadius:
                                                  new BorderRadius.all(new Radius.circular(5.0)),
                                                  boxShadow: [
                                                    BoxShadow(color: Color(0xff4f4d4e), spreadRadius: 1),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Efectivo',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: ((w+h)*.5)*.025,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Color(Colores().btncolor[0]),
                                                  //color: const Color(0xFFFFFF),
                                                  borderRadius:
                                                  new BorderRadius.all(new Radius.circular(5.0)),
                                                  boxShadow: [
                                                    BoxShadow(color: Color(0xff4f4d4e), spreadRadius: 1),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cambio',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: ((w+h)*.5)*.025,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: h*.025,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedButton(
                                        width: ((w+h)*.5)*.1,
                                        height: ((w+h)*.5)*.05,
                                        color: Color(0xfff70300),
                                        onPressed:(){
                                          if(count>1){
                                            setState(() {
                                              count--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Center(
                                            child: Text(
                                              'Cancelar',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: ((w+h)*.5)*.02,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    AnimatedButton(
                                        width: ((w+h)*.5)*.1,
                                        height: ((w+h)*.5)*.05,
                                        color: Color(0xff00ec00),
                                        onPressed:(){
                                          if(count>1){
                                            setState(() {
                                              count--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Center(
                                            child: Text(
                                              'Agregar',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: ((w+h)*.5)*.02,
                                                color: Color(Colores().letracolor[0]),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          /*Expanded(child: Container(
                            height: h*.5,
                            color: Colors.grey,
                          ))*/

                        ],
                      ),
                ))
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
