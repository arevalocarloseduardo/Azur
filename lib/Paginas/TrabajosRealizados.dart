import 'dart:async';
import 'package:azur/Modelos/Servicios.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TrabajosRealizados extends StatefulWidget {
  @override
  _TrabajosRealizadosState createState() => _TrabajosRealizadosState();
}
final serviciosReference = FirebaseDatabase.instance.reference().child('trealizados');
final noticiasReference = FirebaseDatabase.instance.reference().child('trealizados');


class _TrabajosRealizadosState extends State<TrabajosRealizados> {

List<Servicios> listServicios;
StreamSubscription<Event> _onServiciosAddedSubscription;
StreamSubscription<Event> _onServiciosChangedSubscription;

List<String>listaTela =List();
  CarouselSlider instance;
@override
  void initState() {
    super.initState();
    listServicios = new List();
    listServicios.add(new Servicios("_id", "_servicio", "https://www.grupotecnicobarcelona.com/wp-content/uploads/2014/11/trabajos-realizados-reformas-electricidad-51-tn.jpg"));

    
    _onServiciosAddedSubscription =
        serviciosReference.onChildAdded.listen(_onServiciosAdded);
    _onServiciosChangedSubscription =
        serviciosReference.onChildChanged.listen(_onServiciosUpdated);

  
  }
 void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(phone: "542216195020", message: "Hola Somos Azur");
  }
  

  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('images/logo.png');
    var imagenLogo = Image(
      image: assetsImage,
      width: 300.0,
      height: 300.0,
    );
    
    instance=CarouselSlider(
      autoPlay: true,
      autoPlayDuration: Duration(seconds: 3),
      items: listServicios.map((it){
        return Card(margin: EdgeInsets.only(left: 8,right: 8,top: 1),
                    clipBehavior: Clip.hardEdge,
                    elevation: 4,
                    color: Colors.grey,
                 //   shape: RoundedRectangleBorder(         borderRadius: BorderRadius.circular(30.0),),
                    child:  Image.network(
                      '${it.imageurl}',filterQuality: FilterQuality.low,
                      fit: BoxFit.cover,
                     
                    ),
                  );

      }).toList(),
      
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.indigo[800],
        centerTitle: true,
        title: Text("Trabajos Realizados"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
             decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  colors: [Color(0xff1a237e), Color(0xff3f51b5)],
                  begin: Alignment.centerRight,
                  end: Alignment(-1.0, -1.0),
                )),
            child: Column(children: <Widget>[
              
              imagenLogo,
              instance
            ],

            ),
          ),
        ],
      )
    );


    /*
    Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 350),
                  child: InkWell(
                    onTap: () => [
                      whatsAppOpen()
                    ],
                    child:Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 10,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Image.network(
                      '${listServicios[index].imageurl}',
                      fit: BoxFit.cover,
                    ),
                  ),) 
                ),
                Center(
                  child: Text(
                    '${listServicios[index].servicio}',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 0.0),
                            blurRadius: 15.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),
                  ),
                ),
                
              ],
            ),
          );
        },
        control: SwiperControl(),
        loop: false,
        itemCount: listServicios.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    */ 
  }
  void _onServiciosAdded(Event event) {
        setState(
      () {
        listServicios.add(new Servicios.fromSnapshot(event.snapshot));
      },
    );
  }

  void _onServiciosUpdated(Event event) {
    var oldEspecialistasValue =
        listServicios.singleWhere((espe) => espe.id == event.snapshot.key);

    setState(
      () {
        listServicios[listServicios.indexOf(oldEspecialistasValue)] =
            new Servicios.fromSnapshot(event.snapshot);
      },
    );
  }
}