import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Clase_estadistica {
  String candidato;
  int votos;
  charts.Color color;

  Clase_estadistica(candidato, votos, color) {
    this.candidato = candidato;
    this.votos = votos;
    this.color = color;
  }
}
