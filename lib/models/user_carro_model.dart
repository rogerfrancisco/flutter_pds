import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/carro_model.dart';

class UserCarroModel {
  String uid;
  DocumentReference reference;
  List<CarroModel> carros;

  UserCarroModel({
    required this.uid,
    required this.carros,
    required this.reference,
  });

  factory UserCarroModel.fromJson(
      Map<String, dynamic> json, DocumentReference ref) {
    return UserCarroModel(
      uid: json['uid'],
      carros: List<CarroModel>.from(
          json['carros'].map((x) => CarroModel.fromJson(x))),
      reference: ref,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'carros': List<Map<String, dynamic>>.from(carros.map((x) => x.toJson())),
    };
  }
}
