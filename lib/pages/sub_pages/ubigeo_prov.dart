import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelos/clase_estadistica.dart';
import 'package:flutter_application_1/modelos/ubigeo.dart';
import 'package:flutter_application_1/pages/sub_pages/Estadisticas.dart';
import 'package:flutter_application_1/pages/sub_pages/ubigeo_dis.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

String id;

class Ubigeoprov extends StatefulWidget {
  Ubigeoprov(cadena) {
    id = cadena;
  }
  @override
  _Ubigeoprov createState() => _Ubigeoprov();
}

class _Ubigeoprov extends State<Ubigeoprov> {
  Future<List<Ubigeo>> _listaprov;
  Future<List<Ubigeo>> _getUbigeo() async {
    var url = Uri.parse("http://192.168.0.14:8002/get_prov/$id");
    final respuesta = await http.get(url);
    List<Ubigeo> cand = [];
    if (respuesta.statusCode == 200) {
      String cuerpo = utf8.decode(respuesta.bodyBytes);
      final jasodata = jsonDecode(cuerpo);
      for (var i in jasodata) {
        if (i["des_prov"] != "") {
          cand.add(Ubigeo(i["id_ubigeo"], i["cod_dep"], i["cod_prov"],
              i["cod_dist"], i["des_dep"], i["des_prov"], i["des_dist"]));
        }
      }
      return cand;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    _listaprov = _getUbigeo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Provincias"),
      ),
      body: FutureBuilder(
        future: _listaprov,
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
                child: Text(i.prov,
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
                                builder: (context) =>
                                    Ubigeodist(i.iddep, i.idprov)));
                      },
                      child: Text(
                        "Distritos",
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
                                    Estadisticas(i.iddep, i.idprov, null)));
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
