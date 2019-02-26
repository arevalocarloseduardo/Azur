import 'dart:async';
import 'package:azur/Modelos/Servicios.dart';
import 'package:azur/Paginas/TrabajosRealizados.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

final serviciosReference =
    FirebaseDatabase.instance.reference().child('servicios');

class _ServiciosPageState extends State<ServiciosPage> {
  List<Servicios> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    _onNoteAddedSubscription =
        serviciosReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        serviciosReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "jajaj",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          centerTitle: true,
          title: Text("Selecciona Servicios"),
        ),
        body: Center(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[

                InkWell(
                  onTap: () => _navigateToNote(context, items[position]),
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
                          Text(
                            '${items[position].servicio}',
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.deepPurple,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.right,
                          )
                          
                        ],
                      ),),
                ),
                )
                
              ],
              
            );
          },
        )),
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
}
