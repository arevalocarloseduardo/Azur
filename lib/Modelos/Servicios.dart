import 'package:firebase_database/firebase_database.dart';
 
class Servicios {
  String _id;
  String _servicio;
  String _imageurl;
 
  Servicios(this._id, this._servicio, this._imageurl);
 
  Servicios.map(dynamic obj) {
    this._id = obj['id'];
    this._servicio = obj['servicio'];
    this._imageurl = obj['imageurl'];
  }
 
  String get id => _id;
  String get servicio => _servicio;
  String get imageurl => _imageurl;
 
  Servicios.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _servicio = snapshot.value['servicio'];
    _imageurl = snapshot.value['imageurl'];
  }
}