import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaImagenes extends StatefulWidget{
  ListaImagenes({Key key}) : super (key:key);
  @override
  _ListaImagenesState createState () => _ListaImagenesState();

}
 class _ListaImagenesState extends State<ListaImagenes>{
  @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Mi lista de imagenes'),),
      body: ListView.builder(itemBuilder: (BuildContext context,int posic){
      return Card(
        child: ListTile(
          title: Text('Mi titulo'),
          subtitle: Text('Mi subtitulo'),
          leading: Icon(Icons.perm_identity),
          trailing: Icon(Icons.delete),
        ),
      );
      },
      ),
    );
  }
 }