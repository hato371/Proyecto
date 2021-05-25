import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_fasty/Admi/imagen.dart';

class BDatosHelper {
  static BDatosHelper _bdhelper;

  BDatosHelper._createInstance();

  static Database _database;

  String imagenTable = 'imagenTable';
  String columnId = 'id';
  String columnFoto = 'foto';
  String columnTitulo = 'titulo';

  factory BDatosHelper() {
    if (_bdhelper == null) {
      _bdhelper = BDatosHelper._createInstance();
    }
    return _bdhelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDataBase();
    }
    return _database;
  }

  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'imagen.db';
    var imagenDataBase =
        await openDatabase(path, version: 1, onCreate: _createBD);
    return imagenDataBase;
  }

  Future<List<Map<String, dynamic>>> getImagenMapList() async {
    Database db = await this.database;
    var result = await db.query(imagenTable);
    return result;
  }

  void _createBD(Database db, int nuevaversion) async {
    await db.execute(
        'CREATE TABLE $imagenTable ($columnId INTEGER PRIMARY KEY, $columnFoto TEXT, $columnTitulo)');
  }

  Future<int> insertarImagen(Imagen imagen) async {
    Database db = await this.database;
    var result = db.insert(imagenTable, imagen.toMap());
    return result;
  }

  Future<int> actualizarImagen(Imagen imagen) async {
    Database db = await this.database;
    var result = db.update(imagenTable, imagen.toMap(),
        where: '$columnId=?', whereArgs: [imagen.id]);
    return result;
  }

  Future<int> borrarImagen(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $imagenTable WHERE $columnId=$id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> valor =
        await db.rawQuery('SELECT COUNT (*) FROM $imagenTable');
    int result = Sqflite.firstIntValue(valor);
    return result;
  }

  Future<List<Imagen>> getImagenList() async {
    var imagenMapList = await getImagenMapList();
    int count = imagenMapList.length;
    List<Imagen> imagenList = List<Imagen>();
    for (int i = 0; i < count; i++) {
      imagenList.add(Imagen.fromMapObjet(imagenMapList[i]));
    }
    return imagenList;
  }
}
