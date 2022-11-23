import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class KmModel {
  int km;

  KmModel({
    required this.km,
  });

  factory KmModel.fromJson(Map<String, dynamic> json) {
    return KmModel(
      km: json['km'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'km': km,
    };
  }
}
