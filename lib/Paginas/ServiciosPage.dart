import 'dart:async';
import 'package:azur/Modelos/Servicios.dart';
import 'package:azur/Modelos/Utils.dart';
import 'package:azur/Paginas/TrabajosRealizados.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_launch/flutter_launch.dart';


class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

final serviciosReference = FirebaseDatabase.instance.reference().child('servicios');
final utilsReference = FirebaseDatabase.instance.reference().child('utils');

class _ServiciosPageState extends State<ServiciosPage> {
  List<Servicios> items;
  List<Utils> utils;
  String msg ="Hola Azur, quiero un presupuesto, muchas gracias :D";
  String tel ="542216680233";
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
  StreamSubscription<Event> _onUtilsAddedSubscription;
  StreamSubscription<Event> _onUtilsChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    utils = new List();
    _onNoteAddedSubscription =
        serviciosReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        serviciosReference.onChildChanged.listen(_onNoteUpdated);

        _onUtilsAddedSubscription =
        utilsReference.onChildAdded.listen(_onUtilsAdded);
    _onUtilsChangedSubscription =
        utilsReference.onChildChanged.listen(_onUtilsUpdated);
        

        
  }
 

  void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(phone: "542216680233", message: " muchas gracias :D");
  }
  List<String>listaTela =List();
  CarouselSlider instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Azur",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          centerTitle: true,
          title: Text("Selecciona Servicios"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  colors: [Color(0xff1a237e), Color(0xff3f51b5)],
                  begin: Alignment.centerRight,
                  end: Alignment(-1.0, -1.0),
                )),
          ),
            Center(
                child: ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[

                    InkWell(
                      onTap: () => whatsAppOpen() ,
                      child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                '${items[position].imageurl}',
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${items[position].servicio}',
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      color : Colors.orangeAccent,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                              )
                              
                            ],
                          ),),
                    ),
                    )
                    
                  ],
                  
                );
              },
            )),
          ],
        ),
      ),
    );
  }
void _navigateToNote(BuildContext context, Servicios note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrabajosRealizados()),
    );
    }
  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Servicios.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] =
          new Servicios.fromSnapshot(event.snapshot);
    },
    );
  }
  void _onUtilsAdded(Event event) {
    setState(() {
      msg=utils.first.msg;
      tel=utils.first.telefono;
      utils.add(new Utils.fromSnapshot(event.snapshot));
    });
  }

  void _onUtilsUpdated(Event event) {
    var oldUtilsValue =
        utils.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      msg=utils.first.msg;
      tel=utils.first.telefono;
      print(msg);
      utils[utils.indexOf(oldUtilsValue)] =
          new Utils.fromSnapshot(event.snapshot);
    },
    );
  }
}
