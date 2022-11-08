import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/service_model.dart';

class UserServiceModel {
  String placa;
  String uid;
  DocumentReference reference;
  List<ServiceModel> servicos;

  UserServiceModel(
      {required this.uid,
      required this.servicos,
      required this.reference,
      required this.placa});

  factory UserServiceModel.fromJson(
      Map<String, dynamic> json, DocumentReference ref) {
    return UserServiceModel(
      uid: json['uid'],
      servicos: List<ServiceModel>.from(
          json['servicos'].map((x) => ServiceModel.fromJson(x))),
      reference: ref,
      placa: json['placa'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'placa': placa,
      'servicos':
          List<Map<String, dynamic>>.from(servicos.map((x) => x.toJson())),
    };
  }
}
