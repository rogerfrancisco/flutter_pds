import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:untitled/models/auth_error.dart';
import 'package:untitled/models/km_model.dart';
import 'package:untitled/models/user_km_model.dart';

class ServicosKm {
  late final FirebaseFirestore db;
  ServicosKm() {
    db = FirebaseFirestore.instance;
  }
  Future<bool> postKm(int km, String uid, String placa) async {
    try {
      UserKmModel? userKmModel = await getKm(uid, placa);
      if (userKmModel == null) {
        await db.collection('km').add({'uid': uid, 'placa': placa, 'km': km});
      } else if (userKmModel.km < km) {
        userKmModel.km = km;
        await userKmModel.reference.update(userKmModel.toJson());
      } else {
        throw 'Km menor que o anterior';
      }
      return true;
    } on AuthError catch (e) {
      throw e.message;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<UserKmModel?> getKm(String uid, String placa) async {
    try {
      final doc = await db
          .collection('km')
          .where('uid', isEqualTo: uid)
          .where('placa', isEqualTo: placa)
          .orderBy('km', descending: true)
          .limit(1)
          .get();

      if (doc.docs.length == 0) return null;
      return UserKmModel.fromJson(
          doc.docs.first.data(), doc.docs.first.reference);
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<bool> updateKm(KmModel kmModel, String uid, String placa) async {
    try {
      UserKmModel? userKmModel = await getKm(uid, placa);
      if (userKmModel == null) throw 'KM não encontrado';
      userKmModel.km = kmModel.km;
      userKmModel.reference.update(userKmModel.toJson());
      return true;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Stream<UserKmModel?> getKmStream(String uid, String placa) async* {
    try {
      final doc = await db
          .collection('km')
          .where('uid', isEqualTo: uid)
          .where('placa', isEqualTo: placa)
          .orderBy('km', descending: true)
          .limit(1)
          .snapshots();

      if (doc.length == 0) yield null;
      yield* doc.asyncMap((event) => event.docs
          .map((e) => UserKmModel.fromJson(e.data(), e.reference))
          .toList()[0]);
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }
}
