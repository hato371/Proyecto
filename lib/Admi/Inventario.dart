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

class Inventario extends StatefulWidget {
  @override
  _Inventario createState() => _Inventario();
}

class _Inventario extends State<Inventario> {
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
  String sinsumos;
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
  var existencia = new List();
  var entradas = new List();
  var salidas = new List();
  int cantidadinsumos;

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

  final columnas = [
    'Descripcion',
    'Existencias iniciales',
    'Entradas',
    'Salidas',
    'Stock'
  ];

  final tamanos = [200.0, 120.0, 100.0, 80.0, 80.0];

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

  Future<List> _leer() async {
    int valor;
    print("Vaaaaaaaaaaal");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(
        "http://lapalomaburger.000webhostapp.com/leerinsumos.php",
        body: {});

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);
    print(_data.length);
    setState(() {
      cantidadinsumos = _data.length;
      //cantidadtiendas = valor;
      print("Cantidad $cantidadinsumos");
      //preferences.setInt("cantidadtiendas", cantidadtiendas);
      insumos.clear();
      stock.clear();
      //foto.clear();
      setState(() {
        for (int i = 0; i < cantidadinsumos; i++) {
          insumos.add("${_data[i]["descripcion"]}");
          existencia.add("${_data[i]["stock"]}");
          entradas.add(0);
          salidas.add(0);
          stock.add(existencia[i]);
          //foto.add("${_data[i]["imagen"]}");
        }
      });
    });
  }

  Future<List> _rinventario() async {
    int valor;
    print("Vaaaaaaaaaaal");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(
        "http://lapalomaburger.000webhostapp.com/rinventario.php",
        body: {
          "descripcion": descripcion.text
        });

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);

  }

  Future<List> _einventario() async {
    int valor;
    print("Vaaaaaaaaaaal $sinsumos");


    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(
        "http://lapalomaburger.000webhostapp.com/einventario.php",
        body: {
          "descripcion": sinsumos
        });

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);

  }

  Future<List> _aentradas() async {
    int valor;
    print("Vaaaaaaaaaaal $sinsumos");


    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(
        "http://lapalomaburger.000webhostapp.com/ainventario.php",
        body: {
          "descripcion": sinsumos,
          "stock": int.parse(cantidad.text)
        });

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);

  }

  Future<void> _validar() async {
    //_trabajar(media);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    if (descripcion.text.isEmpty) {
      setState(() {
        errorContainerHeightdescripcion = ((w + h) * .5) * .05;
        errorIcondescripcion= FontAwesomeIcons.exclamationCircle;
        errordescripcion = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightdescripcion = 0.0;
        errorIcondescripcion = null;
        errordescripcion= '';
      });
    }
    if(descripcion.text.isEmpty){
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildAgregarI(context, tipo),
      );
    }else{
      await _rinventario();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inventario()), //MaterialPageRoute
      );

    }
}

  Future<void> _validare() async {
    //_trabajar(media);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
      await _einventario();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inventario()), //MaterialPageRoute
      );


  }

  Future<void> _validara() async {
    //_trabajar(media);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    if (cantidad.text.isEmpty) {
      setState(() {
        errorContainerHeightcantidad = ((w + h) * .5) * .05;
        errorIconcantidad= FontAwesomeIcons.exclamationCircle;
        errorcantidad = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightcantidad = 0.0;
        errorIconcantidad = null;
        errorcantidad= '';
      });
    }
    if(cantidad.text.isEmpty){
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildEntradas(context, tipo),
      );
    }else{
      await _aentradas();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inventario()), //MaterialPageRoute
      );

    }
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
                "Inventario",
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Container(
                          height: ((w + h) * .5) * .075,
                          //width: 300,
                          //height: 300,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              //color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                              // Red border with the width is equal to 5
                              border:
                                  Border.all(width: 2, color: Colors.black54)),
                          child: Center(
                            child: Text(
                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              style: TextStyle(
                                  //color: Color(Colores().pruebacolor[0]),
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .035),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: AnimatedButton(
                          height: ((w + h) * .5) * .075,
                          width: ((w + h) * .5) * .35,
                          onPressed: () {
                            descripcion.clear();
                            setState(() {
                              errorContainerHeightdescripcion = 0.0;
                              errorIcondescripcion = null;
                              errordescripcion= '';
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildAgregarI(context, tipo),
                            );
                          },
                          child: Center(
                            child: Text(
                              "Agregar nuevos insumos",
                              style: TextStyle(
                                  //color: Color(Colores().pruebacolor[0]),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .03),
                            ),
                          ),
                          color: Color(Colores().pruebacolor[0]),
                        ),
                      ),
                      Center(
                        child: AnimatedButton(
                          height: ((w + h) * .5) * .075,
                          onPressed: () {
                            for (int i = 0; i < columnas.length; i++) {
                              if (insumos[i] == null) {
                                lleno = false;
                                break;
                              }
                            }
                            descripcion.clear();
                            setState(() {
                              errorContainerHeightdescripcion = 0.0;
                              errorIcondescripcion = null;
                              errordescripcion= '';
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildEliminar(context, tipo),
                            );
                            //  _validar();
                          },
                          child: Center(
                            child: Text(
                              "Eliminar insumos",
                              style: TextStyle(
                                  //color: Color(Colores().pruebacolor[0]),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ((w + h) * .5) * .03),
                            ),
                          ),
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                          color: Colors.white,
                          //padding: const EdgeInsets.all(40.0),
                          //width: w*.2,
                          width: w,
                          height: h * .5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // color: Colors.white70.withOpacity(.89),
                                color: Color(0xff858585).withOpacity(.35),
                                width: 45,
                                height: h * .5,
                              ),
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(0.0),
                                /*child: DataTable(
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Name',
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Age',
                                      ),
                                    ),
                                  ],
                                  rows: const <DataRow>[
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Mohit')),
                                        DataCell(Text('23')),
                                        DataCell(Text('Professional')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Aditya')),
                                        DataCell(Text('24')),
                                        DataCell(Text('Associate Professor')),
                                      ],
                                    ),
                                  ],
                                ),*/
                                child: DataTable(
                                    sortAscending: false,
                                    columns:
                                        /*DataColumn(
                                        label: Container(
                                            width: 150, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 160, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),
                                      DataColumn(
                                        label: Container(
                                            width: 80, height: 0, child: null),
                                      ),*/
                                        columnas.map((uri) {
                                      int y = columnas.indexOf(uri);
                                      return DataColumn(
                                        label: Container(
                                            width: tamanos[y],
                                            height: 0,
                                            child: null),
                                      );
                                    }).toList(),
                                    rows: insumos.map((url) {
                                      int x = insumos.indexOf(url);
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              '${insumos[x]}',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${existencia[x]}',
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${entradas[x]}',
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${salidas[x]}',
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${stock[x]}',
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList()),
                                /*rows: [
                                        DataRow(
                                            cells: columnas.map((uri) {
                                          int z = columnas.indexOf(uri);
                                          return DataCell(
                                            Text(
                                              ':$z',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList()),
                                        DataRow(
                                            cells: columnas.map((uri) {
                                          int z = columnas.indexOf(uri);
                                          return DataCell(
                                            Text(
                                              ':$z',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList()),
                                        DataRow(
                                            cells: columnas.map((uri) {
                                          int z = columnas.indexOf(uri);
                                          return DataCell(
                                            Text(
                                              ':$z',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList()),
                                      ]*/ /*insumos.map((url) {
                                      int x = insumos.indexOf(url);
                                      return DataRow(
                                          cells: columnas.map((uri) {
                                        int z = columnas.indexOf(uri);
                                        return DataCell(
                                          Text(
                                            ': $x , $z',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList()
                                      );
                                    }).toList(),*/
                              ),
                              Container(
                                // color: Colors.white70.withOpacity(.89),
                                color: Color(0xff858585).withOpacity(.35),
                                width: 45,
                                height: h * .5,
                              ),
                            ],
                          )),
                      Container(
                          color: Colors.white,
                          //padding: const EdgeInsets.all(40.0),
                          //width: w*.2,
                          width: w,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // color: Colors.white70.withOpacity(.89),
                                color: Color(0xff858585).withOpacity(.35),
                                width: 45,
                                height: h * .5,
                              ),
                              Container(
                                  width: 150,
                                  height: 30,
                                  child: Text(
                                    "Descripción",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(Colores().pruebacolor[0]),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ((w + h) * .5) * .03),
                                  )),
                              Container(
                                  width: 180,
                                  height: 30,
                                  child: Text(
                                    "Existencia inicial",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(Colores().pruebacolor[0]),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ((w + h) * .5) * .03),
                                  )),
                              Container(
                                  width: 120,
                                  height: 30,
                                  child: Text(
                                    "Entradas",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(Colores().pruebacolor[0]),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ((w + h) * .5) * .03),
                                  )),
                              Container(
                                  width: 120,
                                  height: 30,
                                  child: Text(
                                    "Salidas",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(Colores().pruebacolor[0]),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ((w + h) * .5) * .03),
                                  )),
                              Container(
                                  width: 95,
                                  height: 30,
                                  child: Text(
                                    "Stock",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(Colores().pruebacolor[0]),
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ((w + h) * .5) * .03),
                                  )),
                              Container(
                                // color: Colors.white70.withOpacity(.89),
                                color: Color(0xff858585).withOpacity(.35),
                                width: 45,
                                height: h * .5,
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                            errorContainerHeightcantidad = 0.0;
                            errorIconcantidad = null;
                            errorcantidad= '';
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

                  items: insumos.map((e) {
                    int z = insumos.indexOf(e);
                    return '${insumos[z]}';
                    //return null;
                  }).toList(),
                  label: "Seleccione opción a eliminar",
                  //hint: "country in menu mode",
                  enabled: lleno,
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  //onChanged: print,
                  onChanged: (String item){
                    setState(() {
                      sinsumos = item;
                    });
                    print("Niveeeel: $sinsumos");
                  },
                  selectedItem: lleno == false ? 'Registro vacío' : insumos[0],
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

                    //Navigator.of(context).pop();
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
                    _validare();
                    //Navigator.of(context).pop();
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
                      items: insumos.map((e) {
                        int z = insumos.indexOf(e);
                        return '${insumos[z]}';
                      }).toList(),
                      label: "Seleccione producto a salir",
                      //hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: insumos[0],
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
                Column(
                  children: [
                    Container(
                      width: ((w + h) * .5) * .45,
                      child: Center(
                        child: DropdownSearch<String>(
                          maxHeight: 150,
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          // items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                          items: insumos.map((e) {
                            int z = insumos.indexOf(e);
                            return '${insumos[z]}';
                          }).toList(),
                          label: "Seleccione producto a entrar",
                          //hint: "country in menu mode",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                            onChanged: (String item) {
                              setState(() {
                                sinsumos = item;
                              });
                              print("Niveeeel: $sinsumos");
                            },
                          selectedItem: insumos[0],
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightcantidad,
                        child: Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errorcantidad,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.transparent)))
                          ],
                        ))
                  ],
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
                    _validara();
                    //Navigator.of(context).pop();
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
                      hintText: 'Descripción',
                      //labelText: 'Descripción',
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
                width: ((w + h) * .5) * .6,
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
                    //_rinventario();
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
                    print("Piso validaaaar");
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    _validar();
                   // Navigator.of(context).pop();
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
