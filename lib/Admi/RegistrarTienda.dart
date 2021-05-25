import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fasty/Admi/FirstPageAdmi.dart';
import 'package:flutter_fasty/Admi/tienda.dart';
import 'package:flutter_fasty/FirstPage.dart';
import 'package:flutter_fasty/Venta.dart';
import 'dart:math' as math;
import 'package:flutter_fasty/values/colors.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_button/animated_button.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
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

class RegistrarTienda extends StatefulWidget {
  @override
  _RegistrarTienda createState() => _RegistrarTienda();
}

class _RegistrarTienda extends State<RegistrarTienda> {
  //obtenerPreferencias();
  int color = 0xff264b99;
  int barcolor = 0xff264b99;
  //1a2a44
  int lvcolor = 0xff1b3280;
  int btncolor = 0xfff4f4f4;
  int letracolor = 0xff010612;
  int selectedIndex = 0;
  int tipo = 0;
  int cantidadtiendas;
  var col = [ShadowDegree.dark, ShadowDegree.light];
  var respi = new List();
  var index = 0;
  //
  /*String username = '';
  String errorUser = '';
  IconData errorIconU;
  double errorContainerHeightU = 0.0;
  TextEditingController user = new TextEditingController();
  FocusNode node1 = FocusNode();*/
  String semail = '';
  String erroremail = '';
  IconData errorIconemail;
  double errorContainerHeightemail = 0.0;
  TextEditingController email = new TextEditingController();
  FocusNode node10 = FocusNode();
  //
  String stelefono = '';
  String errortelefono = '';
  IconData errorIcontelefono;
  double errorContainerHeighttelefono = 0.0;
  TextEditingController telefono = new TextEditingController();
  FocusNode node9 = FocusNode();
  //telefono
  //
  String sdireccionsucursal = '';
  String errordireccionsucursal = '';
  IconData errorIcondireccionsucursal;
  double errorContainerHeightdireccionsucursal = 0.0;
  TextEditingController direccionsucursal = new TextEditingController();
  FocusNode node8 = FocusNode();
  //direccionsucursal
  //
  String scurp = '';
  String errorcurp = '';
  IconData errorIconcurp;
  double errorContainerHeightcurp = 0.0;
  TextEditingController curp = new TextEditingController();
  FocusNode node7 = FocusNode();
  //curp
  String spais = '';
  String errorpais = '';
  IconData errorIconpais;
  double errorContainerHeightpais = 0.0;
  TextEditingController pais = new TextEditingController();
  FocusNode node6 = FocusNode();
  //curp
  // cp
  String scp = '';
  String errorcp = '';
  IconData errorIconcp;
  double errorContainerHeightcp = 0.0;
  TextEditingController cp = new TextEditingController();
  FocusNode node5 = FocusNode();
  //curp
  // ciudad
  String sciudad = '';
  String errorciudad = '';
  IconData errorIconciudad;
  double errorContainerHeightciudad = 0.0;
  TextEditingController ciudad = new TextEditingController();
  FocusNode node4 = FocusNode();
  //
  // direccionfiscal
  String sdireccionfiscal = '';
  String errordireccionfiscal = '';
  IconData errorIcondireccionfiscal;
  double errorContainerHeightdireccionfiscal = 0.0;
  TextEditingController direccionfiscal = new TextEditingController();
  FocusNode node3 = FocusNode();
  //
  // razonsocial
  String srazonsocial = '';
  String errorrazonsocial = '';
  IconData errorIconrazonsocial;
  double errorContainerHeightrazonsocial = 0.0;
  TextEditingController razonsocial = new TextEditingController();
  FocusNode node2 = FocusNode();
  //
  // nombrecomercial
  String snombrecomercial = '';
  String errornombrecomercial = '';
  IconData errorIconnombrecomercial;
  double errorContainerHeightnombrecomercial = 0.0;
  TextEditingController nombrecomercial = new TextEditingController();
  FocusNode node1 = FocusNode();
  //
  //var dir;
  File imageFile;
  final _picker = ImagePicker();
  File _imagen;
  String imagenRuta = '';
  @override
  void initState() {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    obtenerPreferencias();
    //_getImage();
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

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      cantidadtiendas = preferences.getInt("cantidadtiendas") ?? 0;
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

  void tiendas() {
    setState(() {
      cantidadtiendas++;
      respi.clear();
      for (int i = 0; i < cantidadtiendas; i++) {
        respi.add("Tienda ${i + 1}");
      }
    });
  }

  Future _getImage() async {
    final String pathRuta =
        (await getExternalStorageDirectory()).path + '${DateTime.now()}.png';
    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
    final File localImage = await imagen.copy('$pathRuta');
    setState(() {
      _imagen = localImage;

      imagenRuta = pathRuta;
    });
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "¿De dónde quieres tomar la foto?",
                style: TextStyle(
                    //color: Color(Colores().pruebacolor[0]),
                    color: Color(0xffd67700),
                    fontWeight: FontWeight.bold,
                    fontSize: ((w + h) * .5) * .035),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        "Galería",
                        style: TextStyle(
                            //color: Color(Colores().pruebacolor[0]),
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: ((w + h) * .5) * .025),
                      ),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    SizedBox(
                      height: (w + h) * .01,
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text(
                        "Cámara",
                        style: TextStyle(
                            //color: Color(Colores().pruebacolor[0]),
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: ((w + h) * .5) * .025),
                      ),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //final String pathRuta = (await getExternalStorageDirectory()).path + '${DateTime.now()}.png';
    final String pathRuta = (await getExternalStorageDirectory()).path +
        '/Pictures/${DateTime.now()}.png';
    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
    final File localImage = await imagen.copy('$pathRuta');
    setState(() {
      _imagen = localImage;

      imagenRuta = pathRuta;
    });
    preferences.setString("imagen", pathRuta);
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<List> _registrar() async {
    int valor;
    print("Vaaaaaaaaaaal");
    print(nombrecomercial.text);
    print(razonsocial.text);
    print(direccionfiscal.text);
    print(ciudad.text);
    print(cp.text);
    print(pais.text);
    print(curp.text);
    print(direccionsucursal.text);
    print(telefono.text);
    print(email.text);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http
        .post("http://lapalomaburger.000webhostapp.com/registrar.php", body: {
      "nombrecomercial": nombrecomercial.text,
      "razonsocial": razonsocial.text,
      "direccionfiscal": direccionfiscal.text,
      "ciudad": ciudad.text,
      "cp": cp.text,
      "pais": pais.text,
      "curp": curp.text,
      "direccionsucursal": direccionsucursal.text,
      "telefono": telefono.text,
      "email": email.text,
    });

    //var datauser = json.decode(response.body.toString());

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);
    print(_data);
  }

  void _validar() {
    //_trabajar(media);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;
    if (email.text.isEmpty) {
      setState(() {
        errorContainerHeightemail = ((w + h) * .5) * .05;
        errorIconemail = FontAwesomeIcons.exclamationCircle;
        erroremail = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightemail = 0.0;
        errorIconemail = null;
        erroremail = '';
      });
    }
    if (telefono.text.isEmpty) {
      setState(() {
        errorContainerHeighttelefono = ((w + h) * .5) * .05;
        errorIcontelefono = FontAwesomeIcons.exclamationCircle;
        errortelefono = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeighttelefono = 0.0;
        errorIcontelefono = null;
        errortelefono = '';
      });
    }
    //
    if (direccionsucursal.text.isEmpty) {
      setState(() {
        errorContainerHeightdireccionsucursal = ((w + h) * .5) * .05;
        errorIcondireccionsucursal = FontAwesomeIcons.exclamationCircle;
        errordireccionsucursal = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightdireccionsucursal = 0.0;
        errorIcondireccionsucursal = null;
        errordireccionsucursal = '';
      });
    }
    ////
    if (curp.text.isEmpty) {
      setState(() {
        errorContainerHeightcurp = ((w + h) * .5) * .05;
        errorIconcurp = FontAwesomeIcons.exclamationCircle;
        errorcurp = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightcurp = 0.0;
        errorIconcurp = null;
        errorcurp = '';
      });
    }
    ////
    if (pais.text.isEmpty) {
      setState(() {
        errorContainerHeightpais = ((w + h) * .5) * .05;
        errorIconpais = FontAwesomeIcons.exclamationCircle;
        errorpais = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightpais = 0.0;
        errorIconpais = null;
        errorpais = '';
      });
    }
    ////
    if (cp.text.isEmpty) {
      setState(() {
        errorContainerHeightcp = ((w + h) * .5) * .05;
        errorIconcp = FontAwesomeIcons.exclamationCircle;
        errorcp = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightcp = 0.0;
        errorIconcp = null;
        errorcp = '';
      });
    }
    ////
    if (ciudad.text.isEmpty) {
      setState(() {
        errorContainerHeightciudad = ((w + h) * .5) * .05;
        errorIconciudad = FontAwesomeIcons.exclamationCircle;
        errorciudad = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightciudad = 0.0;
        errorIconciudad = null;
        errorciudad = '';
      });
    }
    ////
    if (direccionfiscal.text.isEmpty) {
      setState(() {
        errorContainerHeightdireccionfiscal = ((w + h) * .5) * .05;
        errorIcondireccionfiscal = FontAwesomeIcons.exclamationCircle;
        errordireccionfiscal = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightdireccionfiscal = 0.0;
        errorIcondireccionfiscal = null;
        errordireccionfiscal = '';
      });
    }
    ////
    if (razonsocial.text.isEmpty) {
      setState(() {
        errorContainerHeightrazonsocial = ((w + h) * .5) * .05;
        errorIconrazonsocial = FontAwesomeIcons.exclamationCircle;
        errorrazonsocial = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightrazonsocial = 0.0;
        errorIconrazonsocial = null;
        errorrazonsocial = '';
      });
    }
    ////
    if (nombrecomercial.text.isEmpty) {
      setState(() {
        errorContainerHeightnombrecomercial = ((w + h) * .5) * .05;
        errorIconnombrecomercial = FontAwesomeIcons.exclamationCircle;
        errornombrecomercial = 'Este campo esta vacío!';
        //a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightnombrecomercial = 0.0;
        errorIconnombrecomercial = null;
        errornombrecomercial = '';
      });
    }
    //
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => tienda()), //MaterialPageRoute
    );*/
    if (email.text.isNotEmpty && telefono.text.isNotEmpty && direccionsucursal.text.isNotEmpty && curp.text.isNotEmpty && pais.text.isNotEmpty && cp.text.isNotEmpty && ciudad.text.isNotEmpty && direccionfiscal.text.isNotEmpty && razonsocial.text.isNotEmpty && nombrecomercial.text.isNotEmpty) {
      /*setState(() {
        errorContainerHeightP = 35.0;
        errorIconP = FontAwesomeIcons.exclamationCircle;
        errorPass = 'Este campo esta vacío!.';
      });*/
      //user.clear();
      //node1.unfocus();
      //pass.clear();
      //node2.unfocus();
      _registrar();
    }
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
    //var dir;
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
              "Registra tu tienda",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: ((w + h) * .5) * .6,
                //height: ((w+h)*.5)*.1,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(Colores().btncolor[tipo]),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        //  color: Color.fromRGBO(60, 122, 161, .2),
                        //  blurRadius: 20.0,
                        //    offset: Offset(0, 10)
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      //color:Colors.red,
                      //height:  ((w+h)*.5)*.1,
                      //padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          controller: nombrecomercial,
                          focusNode: node1,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                            //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                              labelStyle: TextStyle(
                                fontSize: ((w + h) * .5) * .035,
                                color: Color(Colores().letracolor[tipo]),
                              ),
                              labelText: 'Nombre comercial',
                              //filled: true,
                              fillColor: Color(Colores().btncolor[tipo]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide(
                                  color: errornombrecomercial.isEmpty
                                      ? Color(Colores().letracolor[tipo])
                                      : Colors.red[700],
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: errornombrecomercial.isEmpty
                                        ? Color(Colores().letracolor[tipo])
                                        : Colors.red[700],
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0))),
                          style: new TextStyle(
                            //fontSize: 18,
                              color: Color(Colores().letracolor[tipo])),
                          cursorColor: Color(Colores().letracolor[tipo]),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightnombrecomercial,
                        child: Row(
                          children: <Widget>[
                            Icon(errorIconnombrecomercial,
                                size: 20.0, color: Colors.red[700]),
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errornombrecomercial,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.red[700])))
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      //color:Colors.red,
                      //height:  ((w+h)*.5)*.1,
                      //padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          controller: razonsocial,
                          focusNode: node2,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                            //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                              labelStyle: TextStyle(
                                fontSize: ((w + h) * .5) * .035,
                                color: Color(Colores().letracolor[tipo]),
                              ),
                              labelText: 'Razón social',
                              //filled: true,
                              fillColor: Color(Colores().btncolor[tipo]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide(
                                  color: errorrazonsocial.isEmpty
                                      ? Color(Colores().letracolor[tipo])
                                      : Colors.red[700],
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: errorrazonsocial.isEmpty
                                        ? Color(Colores().letracolor[tipo])
                                        : Colors.red[700],
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0))),
                          style: new TextStyle(
                              color: Color(Colores().letracolor[tipo])),
                          cursorColor: Color(Colores().letracolor[tipo]),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightrazonsocial,
                        child: Row(
                          children: <Widget>[
                            Icon(errorIconrazonsocial,
                                size: 20.0, color: Colors.red[700]),
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errorrazonsocial,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.red[700])))
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      //color:Colors.red,
                      //height:  ((w+h)*.5)*.1,
                      //padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          controller: direccionfiscal,
                          focusNode: node3,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(

                            //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                              labelStyle: TextStyle(
                                fontSize: ((w + h) * .5) * .035,
                                color: Color(Colores().letracolor[tipo]),
                              ),
                              labelText: 'Dirección fiscal',
                              //filled: true,
                              fillColor: Color(Colores().btncolor[tipo]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide(
                                  color: errordireccionfiscal.isEmpty
                                      ? Color(Colores().letracolor[tipo])
                                      : Colors.red[700],
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: errordireccionfiscal.isEmpty
                                        ? Color(Colores().letracolor[tipo])
                                        : Colors.red[700],
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0))),
                          style: new TextStyle(
                              color: Color(Colores().letracolor[tipo])),
                          cursorColor: Color(Colores().letracolor[tipo]),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: errorContainerHeightdireccionfiscal,
                        child: Row(
                          children: <Widget>[
                            Icon(errorIcondireccionfiscal,
                                size: 20.0, color: Colors.red[700]),
                            Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(errordireccionfiscal,
                                    style: TextStyle(
                                        fontSize: (((w + h) * .5) * .023),
                                        color: Colors.red[700])))
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              //color:Colors.red,
                              //height:  ((w+h)*.5)*.1,
                                width: ((w + h) * .5) * .27,
                                //padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  controller: ciudad,
                                  focusNode: node4,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(

                                    //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                      labelStyle: TextStyle(
                                        fontSize: ((w + h) * .5) * .035,
                                        color: Color(
                                            Colores().letracolor[tipo]),
                                      ),
                                      labelText: 'Ciudad',
                                      //filled: true,
                                      fillColor:
                                      Color(Colores().btncolor[tipo]),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                        borderSide: BorderSide(
                                          color: errorciudad.isEmpty
                                              ? Color(Colores()
                                              .letracolor[tipo])
                                              : Colors.red[700],
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(3.0),
                                          borderSide: BorderSide(
                                            color: errorciudad.isEmpty
                                                ? Color(Colores()
                                                .letracolor[tipo])
                                                : Colors.red[700],
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              3.0),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0))),
                                  style: new TextStyle(
                                      color: Color(
                                          Colores().letracolor[tipo])),
                                  cursorColor:
                                  Color(Colores().letracolor[tipo]),
                                )),
                            Container(
                              //color: Colors.red,
                                padding: EdgeInsets.only(left: 10.0),
                                height: errorContainerHeightciudad,
                                child: Row(
                                  children: <Widget>[
                                    Icon(errorIconciudad,
                                        size: 20.0, color: Colors.red[700]),
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(errorciudad,
                                            style: TextStyle(
                                                fontSize:
                                                (((w + h) * .5) * .023),
                                                color: Colors.red[700])))
                                  ],
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              //color:Colors.red,
                              //height:  ((w+h)*.5)*.1,
                                width: ((w + h) * .5) * .27,
                                //padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  controller: cp,
                                  focusNode: node5,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(

                                    //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                      labelStyle: TextStyle(
                                        fontSize: ((w + h) * .5) * .035,
                                        color: Color(
                                            Colores().letracolor[tipo]),
                                      ),
                                      labelText: 'C.P',
                                      //filled: true,
                                      fillColor:
                                      Color(Colores().btncolor[tipo]),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                        borderSide: BorderSide(
                                          color: errorcp.isEmpty
                                              ? Color(Colores()
                                              .letracolor[tipo])
                                              : Colors.red[700],
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(3.0),
                                          borderSide: BorderSide(
                                            color: errorcp.isEmpty
                                                ? Color(Colores()
                                                .letracolor[tipo])
                                                : Colors.red[700],
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              3.0),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0))),
                                  style: new TextStyle(
                                      color: Color(
                                          Colores().letracolor[tipo])),
                                  cursorColor:
                                  Color(Colores().letracolor[tipo]),
                                )),
                            Container(
                              //color: Colors.red,
                                padding: EdgeInsets.only(left: 10.0),
                                height: errorContainerHeightcp,
                                child: Row(
                                  children: <Widget>[
                                    Icon(errorIconcp,
                                        size: 20.0, color: Colors.red[700]),
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(errorcp,
                                            style: TextStyle(
                                                fontSize:
                                                (((w + h) * .5) * .023),
                                                color: Colors.red[700])))
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              //color:Colors.red,
                                height: ((w + h) * .5) * .1,
                                width: ((w + h) * .5) * .27,
                                //padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  controller: pais,
                                  focusNode: node6,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(

                                    //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                      labelStyle: TextStyle(
                                        fontSize: ((w + h) * .5) * .035,
                                        color: Color(
                                            Colores().letracolor[tipo]),
                                      ),
                                      labelText: 'País',
                                      //filled: true,
                                      fillColor:
                                      Color(Colores().btncolor[tipo]),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                        borderSide: BorderSide(
                                          color: errorpais.isEmpty
                                              ? Color(Colores()
                                              .letracolor[tipo])
                                              : Colors.red[700],
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(3.0),
                                          borderSide: BorderSide(
                                            color: errorpais.isEmpty
                                                ? Color(Colores()
                                                .letracolor[tipo])
                                                : Colors.red[700],
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              3.0),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0))),
                                  style: new TextStyle(
                                      color: Color(
                                          Colores().letracolor[tipo])),
                                  cursorColor:
                                  Color(Colores().letracolor[tipo]),
                                )),
                            Container(
                              //color: Colors.red,
                                padding: EdgeInsets.only(left: 10.0),
                                height: errorContainerHeightpais,
                                child: Row(
                                  children: <Widget>[
                                    Icon(errorIconpais,
                                        size: 20.0, color: Colors.red[700]),
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(errorpais,
                                            style: TextStyle(
                                                fontSize:
                                                (((w + h) * .5) * .023),
                                                color: Colors.red[700])))
                                  ],
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              //color:Colors.red,
                                height: ((w + h) * .5) * .1,
                                width: ((w + h) * .5) * .27,
                                //padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  controller: curp,
                                  focusNode: node7,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(

                                    //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                      labelStyle: TextStyle(
                                        fontSize: ((w + h) * .5) * .035,
                                        color: Color(
                                            Colores().letracolor[tipo]),
                                      ),
                                      labelText: 'CURP',
                                      //filled: true,
                                      fillColor:
                                      Color(Colores().btncolor[tipo]),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(3.0),
                                        borderSide: BorderSide(
                                          color: errorcurp.isEmpty
                                              ? Color(Colores()
                                              .letracolor[tipo])
                                              : Colors.red[700],
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(3.0),
                                          borderSide: BorderSide(
                                            color: errorcurp.isEmpty
                                                ? Color(Colores()
                                                .letracolor[tipo])
                                                : Colors.red[700],
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              3.0),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.0))),
                                  style: new TextStyle(
                                      color: Color(
                                          Colores().letracolor[tipo])),
                                  cursorColor:
                                  Color(Colores().letracolor[tipo]),
                                )),
                            Container(
                              //color: Colors.red,
                                padding: EdgeInsets.only(left: 10.0),
                                height: errorContainerHeightcurp,
                                child: Row(
                                  children: <Widget>[
                                    Icon(errorIconcurp,
                                        size: 20.0, color: Colors.red[700]),
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(errorcurp,
                                            style: TextStyle(
                                                fontSize:
                                                (((w + h) * .5) * .023),
                                                color: Colors.red[700])))
                                  ],
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: ((w + h) * .5) * .6,
                    //height: ((w+h)*.5)*.1,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(Colores().btncolor[tipo]),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            //  color: Color.fromRGBO(60, 122, 161, .2),
                            //  blurRadius: 20.0,
                            //    offset: Offset(0, 10)
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          //color:Colors.red,
                          //height:  ((w+h)*.5)*.1,
                          //padding: EdgeInsets.all(1.0),
                            child: TextFormField(
                              controller: direccionsucursal,
                              focusNode: node8,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(

                                //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                  labelStyle: TextStyle(
                                    fontSize: ((w + h) * .5) * .035,
                                    color: Color(Colores().letracolor[tipo]),
                                  ),
                                  labelText: 'Dirección sucursal',
                                  //filled: true,
                                  fillColor: Color(Colores().btncolor[tipo]),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                    borderSide: BorderSide(
                                      color: errordireccionsucursal.isEmpty
                                          ? Color(Colores().letracolor[tipo])
                                          : Colors.red[700],
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                        color: errordireccionsucursal.isEmpty
                                            ? Color(Colores().letracolor[tipo])
                                            : Colors.red[700],
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      new BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              style: new TextStyle(
                                  color: Color(Colores().letracolor[tipo])),
                              cursorColor: Color(Colores().letracolor[tipo]),
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            height: errorContainerHeightdireccionsucursal,
                            child: Row(
                              children: <Widget>[
                                Icon(errorIcondireccionsucursal,
                                    size: 20.0, color: Colors.red[700]),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(errordireccionsucursal,
                                        style: TextStyle(
                                            fontSize:
                                            (((w + h) * .5) * .023),
                                            color: Colors.red[700])))
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //color:Colors.red,
                          //height:  ((w+h)*.5)*.1,
                          //padding: EdgeInsets.all(1.0),
                            child: TextFormField(
                              controller: telefono,
                              focusNode: node9,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(

                                //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                  labelStyle: TextStyle(
                                    fontSize: ((w + h) * .5) * .035,
                                    color: Color(Colores().letracolor[tipo]),
                                  ),
                                  labelText: 'Teléfono',
                                  //filled: true,
                                  fillColor: Color(Colores().btncolor[tipo]),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                    borderSide: BorderSide(
                                      color: errortelefono.isEmpty
                                          ? Color(Colores().letracolor[tipo])
                                          : Colors.red[700],
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                        color: errortelefono.isEmpty
                                            ? Color(Colores().letracolor[tipo])
                                            : Colors.red[700],
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      new BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              style: new TextStyle(
                                  color: Color(Colores().letracolor[tipo])),
                              cursorColor: Color(Colores().letracolor[tipo]),
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            height: errorContainerHeighttelefono,
                            child: Row(
                              children: <Widget>[
                                Icon(errorIcontelefono,
                                    size: 20.0, color: Colors.red[700]),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(errortelefono,
                                        style: TextStyle(
                                            fontSize:
                                            (((w + h) * .5) * .023),
                                            color: Colors.red[700])))
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //color:Colors.red,
                          //height:  ((w+h)*.5)*.1,
                          //padding: EdgeInsets.all(1.0),
                            child: TextFormField(
                              controller: email,
                              focusNode: node10,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(

                                //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                  labelStyle: TextStyle(
                                    fontSize: ((w + h) * .5) * .035,
                                    color: Color(Colores().letracolor[tipo]),
                                  ),
                                  labelText: 'E-mail',
                                  //filled: true,
                                  fillColor: Color(Colores().btncolor[tipo]),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                    borderSide: BorderSide(
                                      color: erroremail.isEmpty
                                          ? Color(Colores().letracolor[tipo])
                                          : Colors.red[700],
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                        color: erroremail.isEmpty
                                            ? Color(Colores().letracolor[tipo])
                                            : Colors.red[700],
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      new BorderRadius.circular(3.0),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              style: new TextStyle(
                                  color: Color(Colores().letracolor[tipo])),
                              cursorColor: Color(Colores().letracolor[tipo]),
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            height: errorContainerHeightemail,
                            child: Row(
                              children: <Widget>[
                                Icon(errorIconemail,
                                    size: 20.0, color: Colors.red[700]),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(erroremail,
                                        style: TextStyle(
                                            fontSize:
                                            (((w + h) * .5) * .023),
                                            color: Colors.red[700])))
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AnimatedButton(
                      height: ((w + h) * .5) * .2,
                      width: ((w + h) * .5) * .2,
                      color: Colors.transparent,
                      onPressed: () {
                        //tiendas();
                        _showSelectionDialog(context);
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Registrar()), //MaterialPageRoute
                        );*/
                      },
                      child: _imagen != null
                          ? CircleAvatar(
                        radius: 120,
                        backgroundImage: FileImage(_imagen),
                        //backgroundImage: Image.file(imageFile),
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
                      )
                    /*child: Container(
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
                            children: <Widget>[
                              _setImageView(w,h)
                            ],
                            /*children: [
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
                            ],*/
                          )),*/
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: AnimatedButton(
              onPressed: () {
                _validar();
              },
              child: Center(
                child: Text(
                  "Continuar",
                  style: TextStyle(
                    //color: Color(Colores().pruebacolor[0]),
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: ((w + h) * .5) * .035),
                ),
              ),
              color: Color(Colores().pruebacolor[0]),
            ),
          )
        ],
      )
          //body: ContactsPage()
          ),
    );
    //});
  }



  Widget _setImageView(w, h) {
    if (imageFile != null) {
      return Image.file(
        imageFile,
        height: ((w + h) * .5) * .2,
        width: ((w + h) * .5) * .2,
      );
    } else {
      return Text("Selecciona imagen");
    }
  }
}
