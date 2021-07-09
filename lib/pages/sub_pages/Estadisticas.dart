import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelos/clase_estadistica.dart';
import 'package:flutter_application_1/modelos/ubigeo.dart';
import 'package:flutter_application_1/pages/sub_pages/candidato.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

String id1 = null;
String id2 = null;
String id3 = null;

class Estadisticas extends StatefulWidget {
  Estadisticas(cad, cad2, cad3) {
    id1 = cad;
    id2 = cad2;
    id3 = cad3;
  }
  @override
  _Estadisticas createState() => _Estadisticas();
}

class _Estadisticas extends State<Estadisticas> {
  List<Clase_estadistica> _listacand;

  Future<List<Clase_estadistica>> _getCand() async {
    var url = Uri.parse("http://192.168.0.14:8002/get_votos");
    var respuesta = await http.post(url,
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode({
          "ubigeo_cod_dep": id1,
          "ubigeo_cod_prov": id2,
          "ubigeo_cod_dist": id3
        }));

    List<Clase_estadistica> cand = [];
    if (respuesta.statusCode == 200) {
      String cuerpo = utf8.decode(respuesta.bodyBytes);
      final jasodata = jsonDecode(cuerpo);
      int e = 0;
      for (int i = 0; i < jasodata.length / 2; i++) {
        e = e + 1;
        print(jasodata["name" + "$e"]);
        print(jasodata["votos" + "$e"]);
        cand.add(Clase_estadistica(
            jasodata["name" + "$e"],
            jasodata["votos" + "$e"],
            charts.ColorUtil.fromDartColor(Colors.lightBlue)));
      }
      _listacand = cand;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    //_getCand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Estadisticas"),
        ),
        body: FutureBuilder(
          future: _getCand(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            if (!snapshot.hasData) {
              /*return charts.BarChart(_getSeriesData(_listacand),
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                    labelRotation: 0,
                  )));*/
            } else if (snapshot.hasError) {
              return Text("errror");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  _getSeriesData(lista) {
    List<charts.Series<Clase_estadistica, String>> series = [
      charts.Series(
          id: "Population",
          data: lista,
          domainFn: (Clase_estadistica series, _) =>
              series.candidato.toString(),
          measureFn: (Clase_estadistica series, _) => series.votos,
          colorFn: (Clase_estadistica series, _) => series.color)
    ];
    return series;
  }
}
