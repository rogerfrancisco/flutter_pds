import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String mecanico;
  DateTime data;
  String horario;
  String mediaKm;
  String observacao;
  String servico;
  String trocaKm;

  ServiceModel({
    required this.mecanico,
    required this.data,
    required this.horario,
    required this.mediaKm,
    required this.observacao,
    required this.servico,
    required this.trocaKm,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      mecanico: json['mecanico'],
      data: json['data'].toDate(),
      horario: json['horario'],
      mediaKm: json['mediaKm'],
      observacao: json['observacao'],
      servico: json['servico'],
      trocaKm: json['trocaKm'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mecanico': mecanico,
      'data': Timestamp.fromDate(data),
      'horario': horario,
      'mediaKm': mediaKm,
      'observacao': observacao,
      'servico': servico,
      'trocaKm': trocaKm,
    };
  }
}
