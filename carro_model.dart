import 'package:cloud_firestore/cloud_firestore.dart';

class CarroModel {
  String nome;
  String marca;
  String modelo;
  String ano;
  String placa;

  CarroModel({
    required this.nome,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.placa,
  });

  factory CarroModel.fromJson(Map<String, dynamic> json) {
    return CarroModel(
      nome: json['nome'],
      marca: json['marca'],
      modelo: json['modelo'],
      ano: json['ano'],
      placa: json['placa'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
    };
  }
}
