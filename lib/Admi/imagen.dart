class Imagen{
  int _id;
  String _foto;
  String _titulo;

  Imagen(this._foto,this._titulo);
  Imagen.id(this._id,this._foto,this._titulo);

  int get id{
    return _id;
  }

  String get foto{
    return _foto;
  }
  String get titulo{
    return _titulo;
  }

  set foto(String nuevafoto){
    this._foto = nuevafoto;
  }
  set titulo(String nuevotitulo){
    this._titulo = nuevotitulo;
  }
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['id']=_id;
    map['foto'] = _foto;
    map['titulo']=_titulo;

    return map;
  }

  Imagen.fromMapObjet(Map<String,dynamic> map){
    this._id=map['id'];
    this._foto=map['foto'];
    this._titulo=map['titulo'];
  }

}