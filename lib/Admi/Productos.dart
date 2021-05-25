import 'dart:convert';
import 'dart:ui';

import 'package:animated_button/animated_button.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_fasty/Admi/RegistrarUsuarios.dart';
import 'package:flutter_fasty/CustomShowDialog.dart';
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

class Productos extends StatefulWidget {
  @override
  _Productos createState() => _Productos();
}

class _Productos extends State<Productos> {
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
  int row = 3;
  int cole = 3;
  var twoDList = List.generate(8, (index) => List(5), growable: false);
  int indiceborrar;
  List<String> _locations = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8'
  ]; // Option 2
  String _selectedLocation; // Option 2

  // nombrecomercial
  String sdescripcion = '';
  String errordescripcion = '';
  IconData errorIcondescripcion;
  double errorContainerHeightdescripcion = 0.0;
  TextEditingController descripcion = new TextEditingController();
  FocusNode node1 = FocusNode();
  //
  // nombrecomercial
  String scantidad = '';
  String errorcantidad = '';
  IconData errorIconcantidad;
  double errorContainerHeightcantidad = 0.0;
  TextEditingController cantidad = new TextEditingController();
  FocusNode node2 = FocusNode();
  //
  bool lleno = true;

  var insumos = new List();
  var stock = new List();
  int cantidadinsumos;
  @override
  void initState() {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    obtenerPreferencias();
  }

  final columnas = [
    'Descripcion',
    'Existencias iniciales',
    'Entradas',
    'Salidas',
    'Stock'
  ];
  final categoria = [
    'Hamburgesas',
    'Alitas'
    /*'Papas',
    'Snacks',
    'Boneless'*/
  ];
  final filas = ['1', '2', '3', '4', '5', '6', '7', '8'];

  Future<void> obtenerPreferencias() async {
    twoDList[0][0] = 'Pan 0 0';
    twoDList[0][1] = 'Pan 0 1';
    twoDList[0][2] = 'Pan 0 2';
    twoDList[0][3] = 'Pan 0 3';
    twoDList[0][4] = 'Pan 0 4';

    /*twoDList[1][0] = 'Pan';
    twoDList[1][1] = 'Pan';
    twoDList[1][2] = 'Pan';
    twoDList[1][3] = 'Pan';
    twoDList[1][4] = 'Pan';*/

    /*twoDList[2][0] = 'Pan';
    twoDList[2][1] = 'Pan';
    twoDList[2][2] = 'Pan';
    twoDList[2][3] = 'Pan';
    twoDList[2][4] = 'Pan';

    twoDList[3][0] = 'Pan';
    twoDList[3][1] = 'Pan';
    twoDList[3][2] = 'Pan';
    twoDList[3][3] = 'Pan';
    twoDList[3][4] = 'Pan';

    twoDList[4][0] = 'Pan';
    twoDList[4][1] = 'Pan';
    twoDList[4][2] = 'Pan';
    twoDList[4][3] = 'Pan';
    twoDList[4][4] = 'Pan';

    twoDList[5][0] = 'Pan';
    twoDList[5][1] = 'Pan';
    twoDList[5][2] = 'Pan';
    twoDList[5][3] = 'Pan';
    twoDList[5][4] = 'Pan';*/

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Exam Prep',
      //theme: theme,
      //color: Colors.red,
      home: Scaffold(
          backgroundColor: Colors.white70.withOpacity(.89),
          appBar: new AppBar(
//          backgroundColor: Color(Colores().color[0]),
            backgroundColor: Color(Colores().pruebacolor[0]),
            leading: IconButton(
                //iconSize: ((media.height/)),
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: (((w + h) * .025)),
                ),
                onPressed: () => _nocambiar()),
            title: Center(
              child: Text(
                "Productos",
                style: TextStyle(
                    //color: Color(Colores().pruebacolor[0]),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ((w + h) * .5) * .035),
              ),
            ),
          ),
          body: Container(
              color: Color(0xff858585).withOpacity(.15),
              width: w,
              height: h,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: w * .8,
                        color: Colors.blue,
                        height: h * .7,
                        child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              //shrinkWrap: true,
                              padding: const EdgeInsets.only(),
                              itemCount: categoria.length,
                              itemBuilder: (BuildContext context, int index) {
                                int z = index;
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: Text(
                                        "${categoria[z]}",
                                        style: TextStyle(
                                          fontSize: h * .05,
                                          color:
                                              Color(Colores().pruebacolor[0]),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * .75,
                                      color: Colors.green,
                                      height: h * .55,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          //shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          itemCount: columnas.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  height: ((w + h) * .5) * .225,
                                                  width: w * .9,
                                                  padding: EdgeInsets.all(10),
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      AnimatedButton(
                                                          height:
                                                              ((w + h) * .5) *
                                                                  .19,
                                                          width:
                                                              ((w + h) * .5) *
                                                                  .19,
                                                          color: Colors
                                                              .transparent,
                                                          //height: 50,
                                                          onPressed: null,
                                                          child: CircleAvatar(
                                                            radius: 120,
                                                            backgroundColor:
                                                                Color(Colores()
                                                                    .pruebacolor[0]),
                                                            //backgroundImage: FileImage(imageFile),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(FontAwesomeIcons
                                                                    .camera),
                                                                Text("Imagen")
                                                              ],
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Usuario ${index + 1}",
                                                            style: TextStyle(
                                                                //color: Color(Colores().pruebacolor[0]),
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: ((w +
                                                                            h) *
                                                                        .5) *
                                                                    .035),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            "Tipo usuario",
                                                            //"Tipo usuario ${index+1}",
                                                            style: TextStyle(
                                                                //color: Color(Colores().pruebacolor[0]),
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: ((w +
                                                                            h) *
                                                                        .5) *
                                                                    .025),
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                //color: Colors.red,
                                                                height: 30,
                                                                child:
                                                                    PopupMenuButton<
                                                                        String>(
                                                                  onSelected:
                                                                      handleClick,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return {
                                                                      'Editar',
                                                                      'Eliminar'
                                                                    }.map((String
                                                                        choice) {
                                                                      return PopupMenuItem<
                                                                          String>(
                                                                        value:
                                                                            choice,
                                                                        child: Text(
                                                                            choice),
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
                                                SizedBox(
                                                  height: 50,
                                                ),
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: AnimatedButton(
                          height: ((w + h) * .5) * .075,
                          width: ((w + h) * .5) * .35,
                          onPressed: () {
                            cantidad.clear();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildEntradas(context, tipo),
                            );
                            //_validar();
                          },
                          child: Center(
                            child: Text(
                              "Agregar entradas",
                              style: TextStyle(
                                  //color: Color(Colores().pruebacolor[0]),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .03),
                            ),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Center(
                        child: AnimatedButton(
                          height: ((w + h) * .5) * .075,
                          width: ((w + h) * .5) * .35,
                          onPressed: () {
                            cantidad.clear();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildSalidas(context, tipo),
                            );
                          },
                          child: Center(
                            child: Text(
                              "Agregar salidas",
                              style: TextStyle(
                                  //color: Color(Colores().pruebacolor[0]),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .03),
                            ),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ))),
      //body: ContactsPage()
    );
    //});
  }

  Widget _buildEliminar(context, tipo) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    double valos = 0;

    return new CustomAlertDialog(
      title: Center(
        child: Text(
          'Eliminar insumos',
          style: TextStyle(
            fontSize: h * .05,
            color: Color(Colores().pruebacolor[0]),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: new Container(
        height: ((w + h) * .5) * .3,
        width: ((w + h) * .5) * .7,
        margin: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          //color: const Color(0xFFFFFF),
          //color: Color(Colores().btncolor[tipo]),
          //color: Colors.red,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: ((w + h) * .5) * .45,
              child: Center(
                child: DropdownSearch<String>(
                  maxHeight: 150,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  // items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],

                  items: columnas.map((e) {
                    int z = columnas.indexOf(e);
                    return '${twoDList[0][z]}';
                    //return null;
                  }).toList(),
                  label: "Seleccione opción a eliminar",
                  //hint: "country in menu mode",
                  enabled: lleno,
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: print,
                  selectedItem:
                      lleno == false ? 'Registro vacío' : twoDList[0][0],
                ),
                /*DropdownButton(
                hint: Text('Please choose a location'), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                    valos = 30;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),*/
              ),
            ),
            SizedBox(
              height: ((w + h) * .5) * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.grey,
                  enabled: true,
                  duration: 10,
                ),
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Eliminar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.red,
                  enabled: true,
                  duration: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalidas(context, tipo) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    double valos = 0;

    return new CustomAlertDialog(
      title: Center(
        child: Text(
          'Agregar salidas',
          style: TextStyle(
            fontSize: h * .05,
            color: Color(Colores().pruebacolor[0]),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: new Container(
        height: ((w + h) * .5) * .3,
        width: ((w + h) * .5) * .8,
        margin: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          //color: const Color(0xFFFFFF),
          //color: Color(Colores().btncolor[tipo]),
          //color: Colors.red,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: ((w + h) * .5) * .45,
                  child: Center(
                    child: DropdownSearch<String>(
                      maxHeight: 150,
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      // items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                      items: columnas.map((e) {
                        int z = columnas.indexOf(e);
                        return '${twoDList[0][z]}';
                      }).toList(),
                      label: "Seleccione producto a salir",
                      //hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: twoDList[0][0],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        //color:Colors.red,
                        width: ((w + h) * .5) * .2,
                        //padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          controller: cantidad,
                          focusNode: node1,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                              //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                              labelStyle: TextStyle(
                                fontSize: ((w + h) * .5) * .025,
                                //color: Color(Colores().letracolor[tipo]),
                                color: Colors.black54,
                              ),
                              labelText: 'Cantidad',
                              //filled: true,
                              fillColor: Color(Colores().btncolor[tipo]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide(
                                  color: errorcantidad.isEmpty
                                      //? Color(Colores().letracolor[tipo])
                                      ? Colors.grey
                                      : Colors.red[700],
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: errorcantidad.isEmpty
                                        //? Color(Colores().letracolor[tipo])
                                        ? Colors.grey
                                        : Colors.red[700],
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          style: new TextStyle(
                              //fontSize: 18,
                              //color: Color(Colores().letracolor[tipo])),
                              color: Colors.black),
                          cursorColor: Colors.black,
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightcantidad,
                        child: Row(
                          children: <Widget>[
                            Icon(errorIconcantidad,
                                size: 20.0, color: Colors.red[700]),
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errorcantidad,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.red[700])))
                          ],
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: ((w + h) * .5) * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.grey,
                  enabled: true,
                  duration: 10,
                ),
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Aceptar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.green,
                  enabled: true,
                  duration: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntradas(context, tipo) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    double valos = 0;

    return new CustomAlertDialog(
      title: Center(
        child: Text(
          'Agregar entradas',
          style: TextStyle(
            fontSize: h * .05,
            color: Color(Colores().pruebacolor[0]),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: new Container(
        height: ((w + h) * .5) * .3,
        width: ((w + h) * .5) * .8,
        margin: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          //color: const Color(0xFFFFFF),
          //color: Color(Colores().btncolor[tipo]),
          //color: Colors.red,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: ((w + h) * .5) * .45,
                  child: Center(
                    child: DropdownSearch<String>(
                      maxHeight: 150,
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      // items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                      items: columnas.map((e) {
                        int z = columnas.indexOf(e);
                        return '${twoDList[0][z]}';
                      }).toList(),
                      label: "Seleccione producto a entrar",
                      //hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: twoDList[0][0],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        //color:Colors.red,
                        width: ((w + h) * .5) * .2,
                        //padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          controller: cantidad,
                          focusNode: node2,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                              //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                              labelStyle: TextStyle(
                                fontSize: ((w + h) * .5) * .025,
                                //color: Color(Colores().letracolor[tipo]),
                                color: Colors.black54,
                              ),
                              labelText: 'Cantidad',
                              //filled: true,
                              fillColor: Color(Colores().btncolor[tipo]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide(
                                  color: errorcantidad.isEmpty
                                      //? Color(Colores().letracolor[tipo])
                                      ? Colors.grey
                                      : Colors.red[700],
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: errorcantidad.isEmpty
                                        //? Color(Colores().letracolor[tipo])
                                        ? Colors.grey
                                        : Colors.red[700],
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          style: new TextStyle(
                              //fontSize: 18,
                              //color: Color(Colores().letracolor[tipo])),
                              color: Colors.black),
                          cursorColor: Colors.black,
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightcantidad,
                        child: Row(
                          children: <Widget>[
                            Icon(errorIconcantidad,
                                size: 20.0, color: Colors.red[700]),
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errorcantidad,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.red[700])))
                          ],
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: ((w + h) * .5) * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.grey,
                  enabled: true,
                  duration: 10,
                ),
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Aceptar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.green,
                  enabled: true,
                  duration: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgregarI(context, tipo) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    double valos = 0;

    return new CustomAlertDialog(
      title: Center(
        child: Text(
          'Agregar nuevos insumos',
          style: TextStyle(
            fontSize: h * .05,
            color: Color(Colores().pruebacolor[0]),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: new Container(
        height: ((w + h) * .5) * .3,
        width: ((w + h) * .5) * .7,
        margin: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          //color: const Color(0xFFFFFF),
          //color: Color(Colores().btncolor[tipo]),
          //color: Colors.red,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                //color:Colors.red,
                width: ((w + h) * .5) * .6,
                //padding: EdgeInsets.all(1.0),
                child: TextFormField(
                  controller: descripcion,
                  focusNode: node1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(

                      //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                      labelStyle: TextStyle(
                        fontSize: ((w + h) * .5) * .025,
                        color: Color(Colores().letracolor[tipo]),
                      ),
                      labelText: 'Descripción',
                      //filled: true,
                      fillColor: Color(Colores().btncolor[tipo]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: BorderSide(
                          color: errordescripcion.isEmpty
                              ? Colors.grey
                              : Colors.red[700],
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          borderSide: BorderSide(
                            color: errordescripcion.isEmpty
                                ? Colors.grey
                                : Colors.red[700],
                          )),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(3.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0))),
                  style: new TextStyle(
                      //fontSize: 18,
                      color: Colors.black),
                  cursorColor: Colors.black,
                )),
            Container(
                padding: EdgeInsets.only(left: 10.0),
                height: errorContainerHeightdescripcion,
                child: Row(
                  children: <Widget>[
                    Icon(errorIcondescripcion,
                        size: 20.0, color: Colors.red[700]),
                    Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(errordescripcion,
                            style: TextStyle(
                                fontSize: (((w + h) * .5) * .023),
                                color: Colors.red[700])))
                  ],
                )),
            /*Container(
              width:((w + h) * .5) * .45,
              child: Center(
                child: DropdownSearch<String>(
                    maxHeight: 150,
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    // items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                    items: columnas.map((e){
                      int z = columnas.indexOf(e);
                      return '${twoDList[0][z]}';
                    }).toList(),
                    label: "Seleccione opción a eliminar",
                    //hint: "country in menu mode",
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: print,
                    //selectedItem:
                ),
              ),
            ),*/
            SizedBox(
              height: ((w + h) * .5) * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.grey,
                  enabled: true,
                  duration: 10,
                ),
                AnimatedButton(
                  //enableFeedback:,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //SizedBox(height: 10),
                        Text(
                          'Aceptar',
                          style: TextStyle(
                            fontSize: ((w + h) * .5) * .035,
                            color: Color(Colores().letracolorop[tipo]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    Navigator.of(context).pop();
                  },
                  // height: ((w + h) * .5) * .115,
                  width: ((w + h) * .5) * .2,
                  shadowDegree: ShadowDegree.values[0],
                  //shadowDegree: col[tipo],
                  color: Colors.green,
                  enabled: true,
                  duration: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
