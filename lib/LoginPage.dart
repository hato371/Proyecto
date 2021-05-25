import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fasty/Admi/FirstPageAdmi.dart';
import 'package:flutter_fasty/FadeAnimation.dart';
import 'package:flutter_fasty/FirstPage.dart';
import 'package:flutter_fasty/values/colors.dart';
import 'package:flutter_fasty/values/perfil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String username = '';
  String errorUser = '';
  IconData errorIconU;
  double errorContainerHeightU = 0.0;
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController textController = new TextEditingController();
  String errorPass = '';
  IconData errorIconP;
  double errorContainerHeightP = 0.0;
  String msg = '';
  double _scale;
  double _scale2;
  double _scale3;
  double _scale4;
  String password = '';
  int p;
  AnimationController _controller;
  AnimationController _controller2;
  AnimationController _controller3;
  AnimationController _controller4;
  bool a1 = true;
  bool a2 = false;
  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  int tipo = 0;

  @override
  void initState() {
    super.initState();
    obtenerPreferencias();
    // _inicar();
    //_pantallainicial();
    /*SystemChrome.setEnabledSystemUIOverlays([
      //systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.pink,
    ]);*/
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));*/
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 10,
      ),
      lowerBound: 0.0,
      upperBound: 0.08,
    )..addListener(() {
      setState(() {});
    });
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 10,
      ),
      lowerBound: 0.0,
      upperBound: 0.08,
    )..addListener(() {
      setState(() {});
    });
    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 10,
      ),
      lowerBound: 0.0,
      upperBound: 0.08,
    )..addListener(() {
      setState(() {});
    });
    _controller4 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 10,
      ),
      lowerBound: 0.0,
      upperBound: 0.08,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      tipo = preferences.getInt("tipo") ?? 0;
      print("eeeeeeeeep $tipo");
      //abc1 = preferences.getDouble("abc1")??0.0;
    });
  }

  Future<void> _entrar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      //username = _data[0]['username'];
      //String nombre = _data[0]['nombre'];
      int rand = Random().nextInt(Perfil().users.length);
      int rand1 = Random().nextInt(1000);
      username = Perfil().users[rand]+rand1.toString();
      //username = _data[0]['username'];
      //print(nombre);
      //username
      preferences.setString("usuario", username);

      preferences.setInt("indice", 0);
      preferences.setInt("tipo", 0);
      preferences.setInt("op", rand);
    });
    showToast('Bienvenido ' + username + '',
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        startOffset: Offset(0.0, 3.0),
        reverseEndOffset: Offset(0.0, 3.0),
        position: StyledToastPosition.bottom,
        duration: Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstPageAdmi()), //MaterialPageRoute
    );
    /*Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => FirstPage()));*/
  }

  /*Future<void> _inicar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.get("usuario"??'user');
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
  }*/

  Future<List> _login() async {
    int valor;
    print("Vaaaaaaaaaaal");
    print(user.text);
    print(pass.text);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http
        .post("http://lapalomaburger.000webhostapp.com/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    //var datauser = json.decode(response.body.toString());

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    var _data = jsonDecode(jsonsDataString);
    //var datauser = response.body.toString();
    //print(datauser[0]['password']);
    print(_data);

    if (_data.length == 0) {
      setState(() {
        msg = "Login Fail";
        /*user.clear();
        node1.unfocus();
        pass.clear();
        node2.unfocus();*/
        print("entro aqui");
        showToast('Usuario o contraseña incorrecta',
            context: context,
            animation: StyledToastAnimation.slideFromBottom,
            reverseAnimation: StyledToastAnimation.slideToBottom,
            startOffset: Offset(0.0, 3.0),
            reverseEndOffset: Offset(0.0, 3.0),
            position: StyledToastPosition.bottom,
            duration: Duration(seconds: 4),
            //Animation duration   animDuration * 2 <= duration
            animDuration: Duration(seconds: 1),
            curve: Curves.elasticOut,
            reverseCurve: Curves.fastOutSlowIn);
        a2 = false;
        user.clear();
        pass.clear();
        FocusScope.of(context).unfocus();
      });
    } else {
      print("si jalo admi");
      setState(() {
        username = _data[0]['username'];
        String nombre = _data[0]['nombre'];
        print(nombre);
       // valor = int.parse(_data[0]["nivel"]);
        String z = _data[0]["nivel"];
        if(z == "Administrador"){
          valor = 1;
        }else if(z=="Gerente"){
          valor = 2;
        }else if(z=="Cajero"){
          valor = 3;
        }else if(z=="Cocinero"){
          valor = 4;
        }
        preferences.setString("usuario", username);



      });
      showToast('Bienvenido ' + username + '',
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          startOffset: Offset(0.0, 3.0),
          reverseEndOffset: Offset(0.0, 3.0),
          position: StyledToastPosition.bottom,
          duration: Duration(seconds: 4),
          //Animation duration   animDuration * 2 <= duration
          animDuration: Duration(seconds: 1),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);

      a2 = false;
      user.clear();
      pass.clear();
      FocusScope.of(context).unfocus();
      //pushReplacementNamed
      /*Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => FirstPage()));*/

      if(valor==1){
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
            child: FirstPageAdmi(),
          ),
        );
      }else{
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
            child: FirstPage(),
          ),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    _scale = 1 - _controller.value;
    _scale2 = 1 - _controller2.value;
    _scale3 = 1 - _controller3.value;
    _scale4 = 1 - _controller4.value;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var h = queryData.size.height;
    var w = queryData.size.width;

    return Scaffold(
        backgroundColor: Colors.white70.withOpacity(.89),
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  // color: Color(Colores().fondocolor[tipo]),
                  /*decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fondoclaro.png"),
                fit: BoxFit.cover,
              ),
            ),*/
                  //height: media.height,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                       // height: media.height / 20,
                      ),
                      FadeAnimation(
                        .5,
                        Container(
                         // color: Colors.red,
                          width: (w+h)*.5,
                          height: (w+h)*.05,
                          /*decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                 // AssetImage('assets/images/logocompleto.png'),
                                  fit: BoxFit.fill)),*/
                        ),
                      ),
                      SizedBox(
                        height: media.height / 50,
                      ),
                      FadeAnimation(
                          1.5,
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Color(Colores().pruebacolor[0]),
                                fontWeight: FontWeight.bold,
                                fontSize: ((w+h)*.5)*.04,
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                                1.8,
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Container(
                                     width:  ((w+h)*.5)*.6,
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
                                               controller: user,
                                               focusNode: node1,
                                               textInputAction: TextInputAction.next,
                                               decoration: InputDecoration(

                                                 //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                                   labelStyle: TextStyle(
                                                     fontSize: ((w+h)*.5)*.035,
                                                     color: Color(Colores().letracolor[tipo]),
                                                   ),
                                                   labelText: 'Nombre de usuario',
                                                   //filled: true,
                                                   fillColor:
                                                   Color(Colores().btncolor[tipo]),

                                                   enabledBorder: OutlineInputBorder(
                                                     borderRadius:
                                                     BorderRadius.circular(3.0),
                                                     borderSide: BorderSide(
                                                       color: errorUser.isEmpty
                                                           ? Color(Colores().letracolor[tipo])
                                                           : Colors.red[700],
                                                     ),
                                                   ),
                                                   focusedBorder: OutlineInputBorder(
                                                       borderRadius:
                                                       BorderRadius.circular(3.0),
                                                       borderSide: BorderSide(
                                                         color: errorUser.isEmpty
                                                             ? Color(Colores().letracolor[tipo])
                                                             : Colors.red[700],
                                                       )),
                                                   border: OutlineInputBorder(
                                                       borderRadius:
                                                       new BorderRadius.circular(
                                                           3.0),
                                                       borderSide: BorderSide(
                                                           color: Colors.black,
                                                           width: 1.0))),
                                               style:
                                               new TextStyle(color: Color(Colores().letracolor[tipo])),cursorColor: Color(Colores().letracolor[tipo]),
                                             )),
                                         Container(
                                             padding: EdgeInsets.only(left: 10.0),
                                             height: errorContainerHeightU,
                                             child: Row(
                                               children: <Widget>[
                                                 Icon(errorIconU,
                                                     size: 20.0,
                                                     color: Colors.red[700]),
                                                 Padding(
                                                     padding:
                                                     EdgeInsets.only(left: 5.0),
                                                     child: Text(errorUser,
                                                         style: TextStyle(
                                                             fontSize:
                                                             ((media.height / 15) /
                                                                 2.7),
                                                             color: Colors.red[700])))
                                               ],
                                             )),
                                       ],
                                     ),
                                   ),
                                   SizedBox(
                                     height: media.width / 50,
                                   ),
                                   Container(
                                     width:  ((w+h)*.5)*.6,
                                     padding: EdgeInsets.all(10),
                                     decoration: BoxDecoration(
                                         color: Color(Colores().btncolor[tipo]),
                                         borderRadius: BorderRadius.circular(10),
                                         boxShadow: [
                                           BoxShadow(
                                               color: Color.fromRGBO(60, 122, 161, .2),
                                               blurRadius: 20.0,
                                               offset: Offset(0, 10))
                                         ]),
                                     child: Column(
                                       children: <Widget>[
                                         Container(
                                             //height:  ((w+h)*.5)*.1,
                                             padding: EdgeInsets.all(1.0),
                                             child: TextFormField(
                                               controller: pass,
                                               focusNode: node2,
                                               textInputAction: TextInputAction.done,
                                               decoration: new InputDecoration(
                                                 //suffixIcon: Icon(Icons.arrow_drop_down, size: 35.0,),
                                                   labelStyle: TextStyle(
                                                     fontSize: ((w+h)*.5)*.035,
                                                     color: Color(Colores().letracolor[tipo]),
                                                   ),
                                                   labelText: 'Contraseña',
                                                   filled: true,
                                                   fillColor:
                                                   Color(Colores().btncolor[tipo]),
                                                   enabledBorder:
                                                   new OutlineInputBorder(
                                                     borderRadius:
                                                     new BorderRadius.circular(
                                                         3.0),
                                                     borderSide: new BorderSide(
                                                       color: errorPass.isEmpty
                                                           ? Color(Colores().letracolor[tipo])
                                                           : Colors.red[700],
                                                     ),
                                                   ),
                                                   focusedBorder:
                                                   new OutlineInputBorder(
                                                       borderRadius:
                                                       new BorderRadius
                                                           .circular(3.0),
                                                       borderSide: new BorderSide(
                                                         color: errorPass.isEmpty
                                                             ? Color(Colores().letracolor[tipo])
                                                             : Colors.red[700],
                                                       )),
                                                   border: OutlineInputBorder(
                                                       borderRadius:
                                                       new BorderRadius.circular(
                                                           3.0),
                                                       borderSide: BorderSide(
                                                           color: Colors.black,
                                                           width: 1.0))),
                                               style:
                                               new TextStyle(color: Color(Colores().letracolor[tipo])),cursorColor: Color(Colores().letracolor[tipo]),
                                             )),
                                         Container(
                                             padding: EdgeInsets.only(left: 10.0),
                                             height: errorContainerHeightP,
                                             child: Row(
                                               children: <Widget>[
                                                 Icon(errorIconP,
                                                     size: 20.0,
                                                     color: Colors.red[700]),
                                                 Padding(
                                                     padding:
                                                     EdgeInsets.only(left: 5.0),
                                                     child: Text(errorPass,
                                                         style: TextStyle(
                                                             fontSize:
                                                             ((media.height / 15) /
                                                                 2.7),
                                                             color: Colors.red[700])))
                                               ],
                                             )),
                                       ],
                                     ),
                                   )
                                 ],
                               )),
                            SizedBox(
                              height: media.height / 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FadeAnimation(
                                    2,
                                    Container(
                                      height: ((w+h)*.5)*.1,
                                      width: media.width / 2 - 40,
                                      child: GestureDetector(
                                        onTapDown: _tapDown2,
                                        onTapUp: _tapUp2,
                                        child: Transform.scale(
                                          scale: _scale2,
                                          child: _animatedButton2(media,w,h),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: media.height / 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  child: Container(
                    height: media.height,
                    width: media.width,
                    color: (Colors.white).withOpacity(.5),
                    child: CupertinoActivityIndicator(
                      // radius: ((media.height/15)/2.7),
                    ),
                  ),
                  visible: a2,
                )
              ],
            )));
  }

  /* void _tapDown(TapDownDetails details) {
    _controller.forward();
    print("aqui");
    // _login();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    print("aca");
    //_validar();
  }*/
  void _tapDown(TapDownDetails details) {
    int _start = 0;
    //_validar();
    const oneSec = const Duration(milliseconds: 10);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 100) {
          setState(() {
            timer.cancel();
            _controller.forward();
          });
        } else {
          _start += 100;
        }
      },
    );

    //_login();
  }


  void _tapUp(TapUpDetails details) {
    int _start = 0;
    //_validar();
    const oneSec = const Duration(milliseconds: 100);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 100) {
          setState(() {
            timer.cancel();
            _controller.reverse();
            int _start = 0;
            _entrar();
            //_validar();
            const oneSec = const Duration(milliseconds: 10);
            Timer _timer = new Timer.periodic(
              oneSec,
                  (Timer timer) {
                if (_start == 100) {
                  setState(() {
                    timer.cancel();
                    /*showDialog(
                      context: context,
                      builder: (BuildContext context) => CodePage2(),
                    );*/
                  });
                } else {
                  _start += 100;
                }
              },
            );
          });
        } else {
          _start += 100;
        }
      },
    );
  }

  Widget _animatedButton(media) {
    return Container(
      height: (media.height / 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(Colores().btnya[tipo]),
        /*gradient: LinearGradient(
            color:
              /*colors: [
                Color.fromRGBO(109, 172, 213, 1),
                Color.fromRGBO(109, 172, 213, .2),
              ]*/
          )*/
      ),
      /*child: FittedBox(
        fit: BoxFit.scaleDown,
        child:
        Text(
          "¡No puedo esperar!",
          //style: TextStyle(fontSize: 18),
        ),),*/
      /*child: AutoSizeText(
          'A really long String',
          style: TextStyle(fontSize: 30),
          maxLines: 1,
        ),*/
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            // child: Visibility(
            child: Text(
              "Iniciar ya!",
              style: TextStyle(
                  color: Color(Colores().letracolorclaro[tipo]),
                  fontWeight: FontWeight.bold,
                  fontSize: ((media.height / 15) / 3)),
            ),
            //visible: a3,
            // ),
          ),
          SizedBox(
            width: media.width / 60,
          ),
          Icon(
            FontAwesomeIcons.lockOpen,
            color: Color(Colores().fondol[tipo]),
          )
          /* Container(
              //padding: EdgeInsets.only(left: 10.0),
              height: (media.height/10)*0,
              width: (media.height/10)*0,
              //child: Center(
                    child: Visibility(
                      child: CupertinoActivityIndicator(
                       // radius: ((media.height/15)/2.7),
                      ),
                     visible: a4, //color: Colors.blue,
                    ),


              //),
          )*/
        ],
      ),
      /*child: Center(
        child: AutoSizeText(
          '¡No puedo esperar!',
          style: TextStyle(fontSize:((media.height/15)/2.5)),
          maxLines: 1,
        ),
      ),*/
    );
  }

  /*void _tapDown2(TapDownDetails details) {
    _controller2.forward();
    //_login();

  }
  void _tapUp2(TapUpDetails details) {
    _controller2.reverse();
    _validar();
  }*/
  void _tapDown2(TapDownDetails details) {
    int _start = 0;
    //_validar();
    const oneSec = const Duration(milliseconds: 10);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 100) {
          setState(() {
            timer.cancel();
            _controller2.forward();
          });
        } else {
          _start += 100;
        }
      },
    );

    //_login();
  }

  void _tapUp2(TapUpDetails details) {
    int _start = 0;
    //_validar();
    const oneSec = const Duration(milliseconds: 100);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 100) {
          setState(() {
            timer.cancel();
            _controller2.reverse();
            int _start = 0;
            //_validar();
            const oneSec = const Duration(milliseconds: 10);
            Timer _timer = new Timer.periodic(
              oneSec,
                  (Timer timer) {
                if (_start == 100) {
                  setState(() {
                    timer.cancel();
                    //a2 = true;
                    //_entrar();
                    _validar();
                    /*showDialog(
                      context: context,
                      builder: (BuildContext context) => CodePage2(),
                    );*/
                  });
                } else {
                  _start += 100;
                }
              },
            );
          });
        } else {
          _start += 100;
        }
      },
    );
  }

  Widget _animatedButton2(media,w,h) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(Colores().pruebacolor[tipo]),
        /*gradient: LinearGradient(
              colors: [
                Color.fromRGBO(60, 136, 226, 1),
                Color.fromRGBO(60, 136, 226, .2),
              ]
          )*/
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            // child: Visibility(
            child: Text(
              "Ingresar",
              style: TextStyle(
                  color: Color(Colores().letracolorclaro[tipo]),
                  fontWeight: FontWeight.bold,
                  fontSize: ((w+h)*.5)*.025),
            ),
            //visible: a3,
            // ),
          ),
          SizedBox(
            width: media.width / 60,
          ),
          Icon(
            FontAwesomeIcons.userCheck,
            color: Color(Colores().letracolorclaro[tipo]),
          )
          /* Container(
              //padding: EdgeInsets.only(left: 10.0),
              height: (media.height/10)*0,
              width: (media.height/10)*0,
              //child: Center(
                    child: Visibility(
                      child: CupertinoActivityIndicator(
                       // radius: ((media.height/15)/2.7),
                      ),
                     visible: a4, //color: Colors.blue,
                    ),


              //),
          )*/
        ],
      ),
      /*child: Center(
        child: AutoSizeText(
          'Ingresar',
          style: TextStyle(fontSize: ((media.height/15)/3)),
          maxLines: 2,
        ),
      ),*/
    );
  }

  void _validar() {
    //_trabajar(media);
    var media = MediaQuery.of(context).size;
    if (user.text.isEmpty) {
      setState(() {
        errorContainerHeightU = (media.height / 15);
        errorIconU = FontAwesomeIcons.exclamationCircle;
        errorUser = 'Este campo esta vacío!.';
        a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightU = 0.0;
        errorIconU = null;
        errorUser = '';
      });
    }
    if (pass.text.isEmpty) {
      setState(() {
        errorContainerHeightP = (media.height / 15);
        errorIconP = FontAwesomeIcons.exclamationCircle;
        errorPass = 'Este campo esta vacío!.';
        a2 = false;
      });
    } else {
      setState(() {
        errorContainerHeightP = 0.0;
        errorIconP = null;
        errorPass = '';
      });
    }
    if (pass.text.isNotEmpty && user.text.isNotEmpty) {
      /*setState(() {
        errorContainerHeightP = 35.0;
        errorIconP = FontAwesomeIcons.exclamationCircle;
        errorPass = 'Este campo esta vacío!.';
      });*/
      //user.clear();
      //node1.unfocus();
      //pass.clear();
      //node2.unfocus();
      _login();
    }
  }
}
