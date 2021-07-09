import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/sub_pages/Estadisticas.dart';
import 'package:flutter_application_1/pages/sub_pages/candiato_estadisticas.dart';
import 'package:flutter_application_1/pages/sub_pages/ubigeo_dep.dart';

class Visitante extends StatefulWidget {
  @override
  _Visitante createState() => _Visitante();
}

class _Visitante extends State<Visitante> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 200),
          logo(context),
          SizedBox(height: 40),
          lista_cand(context), // listado de candidatos
          SizedBox(height: 20),
          butt_pais(context), // estadisticas generales
          SizedBox(height: 20),
          estadisticas_butt(context), //estadisticas filtro
          SizedBox(height: 40),
          retroceder(),
        ],
      ),
    ));
  }

  Widget retroceder() {
    return Align(
      alignment: Alignment.bottomRight,
      child: BackButton(),
    );
  }

  Widget logo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Image.network(
        "https://i.ibb.co/QX5cbMK/logo.png",
        height: 200.0,
      ),
    );
  }

  Widget lista_cand(BuildContext context) {
    return MaterialButton(
        shape: StadiumBorder(),
        highlightColor: Colors.white,
        color: Colors.blueGrey[600],
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Lista_estadisticas()));
        },
        child: Text(
          "Lista de candidatos",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  Widget estadisticas_butt(BuildContext context) {
    return MaterialButton(
        shape: StadiumBorder(),
        highlightColor: Colors.white,
        color: Colors.blueGrey[600],
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Ubigeodep()));
        },
        child: Text(
          "Estadisticas",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  Widget butt_pais(BuildContext context) {
    return MaterialButton(
        shape: StadiumBorder(),
        highlightColor: Colors.white,
        color: Colors.blueGrey[600],
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Estadisticas(null, null, null)));
        },
        child: Text(
          "Estadisticas Perú",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }
}
