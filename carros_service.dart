import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/models/auth_error.dart';
import 'package:untitled/models/carro_model.dart';
import 'package:untitled/models/user_carro_model.dart';

class CarrosService {
  late final FirebaseFirestore db;
  CarrosService() {
    db = FirebaseFirestore.instance;
  }
  Future<bool> postCarro(
    CarroModel carros,
    String uid,
  ) async {
    try {
      UserCarroModel? userCarroModel = await getCarro(uid);
      if (userCarroModel == null) {
        await db.collection('carros').add({
          'uid': uid,
          'carros': [carros.toJson()]
        });
      } else {
        userCarroModel.carros.add(carros);
        await userCarroModel.reference.update(userCarroModel.toJson());
      }
      return true;
    } on AuthError catch (e) {
      throw e.message;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<UserCarroModel?> getCarro(String uid) async {
    try {
      var doc =
          await db.collection('carros').where('uid', isEqualTo: uid).get();
      if (doc.docs.length == 0) return null;
      return UserCarroModel.fromJson(
          doc.docs.first.data(), doc.docs.first.reference);
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<bool> deleteCarro(CarroModel carro, String uid) async {
    try {
      UserCarroModel? userCarroModel = await getCarro(uid);
      if (userCarroModel == null) return false;
      userCarroModel.carros.removeWhere((element) {
        if (element.ano == carro.ano &&
            element.modelo == carro.modelo &&
            element.placa == carro.placa) {
          return true;
        }
        return false;
      });
      if (await updateCarro(userCarroModel)) return true;
      return false;
    } on AuthError catch (e) {
      throw e.message;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<bool> updateCarro(UserCarroModel userCarroModel) async {
    try {
      await userCarroModel.reference.update(userCarroModel.toJson());
      return true;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }
}
