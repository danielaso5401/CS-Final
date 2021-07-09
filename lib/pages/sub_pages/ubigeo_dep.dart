import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelos/clase_estadistica.dart';
import 'package:flutter_application_1/modelos/ubigeo.dart';
import 'package:flutter_application_1/pages/sub_pages/Estadisticas.dart';
import 'package:flutter_application_1/pages/sub_pages/ubigeo_prov.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class Ubigeodep extends StatefulWidget {
  @override
  _Ubigeodep createState() => _Ubigeodep();
}

class _Ubigeodep extends State<Ubigeodep> {
  Future<List<Ubigeo>> _listadep;
  Future<List<Ubigeo>> _getUbigeo() async {
    var url = Uri.parse("http://192.168.0.14:8002/get_dep");
    final respuesta = await http.get(url);
    List<Ubigeo> cand = [];
    if (respuesta.statusCode == 200) {
      String cuerpo = utf8.decode(respuesta.bodyBytes);
      final jasodata = jsonDecode(cuerpo);
      for (var i in jasodata) {
        cand.add(Ubigeo(i["id_ubigeo"], i["cod_dep"], i["cod_prov"],
            i["cod_dist"], i["des_dep"], i["des_prov"], i["des_dist"]));
      }
      return cand;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadep = _getUbigeo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Departamentos"),
      ),
      body: FutureBuilder(
        future: _listadep,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: lista(snapshot.data),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("error");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> lista(List<Ubigeo> data) {
    List<Widget> candi = [];
    for (var i in data) {
      candi.add(Card(
          child: Column(children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //padding: EdgeInsets.all(20.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(i.dep,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      shape: StadiumBorder(),
                      color: Colors.blueGrey[600],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ubigeoprov(i.iddep)));
                      },
                      child: Text(
                        "Provincias",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  FlatButton(
                      shape: StadiumBorder(),
                      color: Colors.blueGrey[600],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Estadisticas(i.iddep, null, null)));
                      },
                      child: Text(
                        "Estaditicas",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))
                ],
              ),
            ])
      ])));
    }
    return candi;
  }
}
