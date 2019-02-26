
import 'package:azur/Paginas/ServiciosPage.dart';
import 'package:azur/Paginas/TrabajosRealizados.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {

  int currentTab = 0;
  TrabajosRealizados one;
  ServiciosPage two;


  List<Widget>pages;
  Widget currentPage;

  @override
  void initState() {
    one = TrabajosRealizados();
    two = ServiciosPage();

    pages =[one,two];

    currentPage=one;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hola",
      home: Scaffold(
       // drawer: Drawer(child: Text("data"),),
    
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
        onTap: (int index){
          setState(() {
           currentTab = index;
           currentPage = pages[index];
          });
        },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                title: Text("Trabajos realizados")),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                title: Text("Solicitar presupuesto")),
          ],
        ),
        body: currentPage 
      ),
    );
  }
  Widget chi=Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Bienvenido a Azur",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Informate de todas nuestras instalaciones que tenemos para vos, al alcanze de tu mano.",
                  style: TextStyle(fontSize: 15, color: Colors.indigo[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
}
