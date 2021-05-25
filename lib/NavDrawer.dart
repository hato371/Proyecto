import 'package:flutter/material.dart';
import 'package:flutter_fasty/values/colors.dart';

class NavDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Container(
        color: Color(0xffd97600),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text(
              'Side menu',
              style: TextStyle(color: Color(Colores().pruebacolor[0]), fontSize: 25),
            ),
              decoration: BoxDecoration(
                color: Colors.white,
                  //color: Color(0xffd97600),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/frenzy.png"),
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text("Welcome"),
              onTap: () => {
                print("pushoooooooo")
              },
            )
          ],
        ),
      )
    );
  }

}