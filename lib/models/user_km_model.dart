import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/km_model.dart';

class UserKmModel {
  String placa;
  String uid;
  DocumentReference reference;
  int km;

  UserKmModel(
      {required this.uid,
      required this.km,
      required this.reference,
      required this.placa});

  factory UserKmModel.fromJson(
      Map<String, dynamic> json, DocumentReference ref) {
    return UserKmModel(
      uid: json['uid'],
      km: json['km'],
      reference: ref,
      placa: json['placa'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'placa': placa,
      'km': km,
    };
  }
}
