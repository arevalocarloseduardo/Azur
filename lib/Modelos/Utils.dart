import 'package:firebase_database/firebase_database.dart';
 
class Utils {
  String _id;
  String _msg;
  String _telefono;
 
  Utils(this._id, this._msg, this._telefono);
 
  Utils.map(dynamic obj) {
    this._id = obj['id'];
    this._msg = obj['msg'];
    this._telefono = obj['telefono'];
  }
 
  String get id => _id;
  String get msg => _msg;
  String get telefono => _telefono;
 
  Utils.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _msg = snapshot.value['msg'];
    _telefono = snapshot.value['telefono'];
  }
}