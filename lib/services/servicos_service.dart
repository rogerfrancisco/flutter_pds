import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/models/auth_error.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/models/user_km_model.dart';
import 'package:untitled/models/user_service_model.dart';
import 'package:untitled/services/km_service.dart';

class ServicosService {
  late final FirebaseFirestore db;
  ServicosService() {
    db = FirebaseFirestore.instance;
  }
  Future<bool> postService(
      ServiceModel service, String uid, String placa) async {
    try {
      UserServiceModel? userServiceModel = await getService(uid, placa);
      if (userServiceModel == null) {
        await db.collection('servicos').add({
          'uid': uid,
          'placa': placa,
          'servicos': [service.toJson()]
        });
      } else {
        userServiceModel.servicos.add(service);
        await userServiceModel.reference.update(userServiceModel.toJson());
      }
      return true;
    } on AuthError catch (e) {
      throw e.message;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<UserServiceModel?> getService(String uid, String placa) async {
    try {
      var doc = await db
          .collection('servicos')
          .where('uid', isEqualTo: uid)
          .where('placa', isEqualTo: placa)
          .get();

      if (doc.docs.length == 0) return null;
      return UserServiceModel.fromJson(
          doc.docs.first.data(), doc.docs.first.reference);
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<bool> deleteService(
      ServiceModel service, String uid, String placa) async {
    try {
      UserServiceModel? userServiceModel = await getService(uid, placa);
      if (userServiceModel == null) return false;
      userServiceModel.servicos.removeWhere((element) {
        if (element.data == service.data &&
            element.servico == service.servico &&
            element.observacao == service.observacao) {
          return true;
        }
        return false;
      });

      return false;
    } on AuthError catch (e) {
      throw e.message;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<bool> updateService(
      ServiceModel serviceModel, String uid, String placa) async {
    try {
      UserServiceModel? userServiceModel = await getService(uid, placa);
      if (userServiceModel == null) throw 'Serviço não encontrado';
      userServiceModel.servicos.removeWhere((element) {
        if (element.data == serviceModel.data &&
            element.servico == serviceModel.servico &&
            element.observacao == serviceModel.observacao) {
          return true;
        }
        return false;
      });
      userServiceModel.servicos.add(serviceModel);
      userServiceModel.reference.update(userServiceModel.toJson());
      return true;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Future<List<ServiceModel>?> getAlerta(String uid, String placa) async {
    try {
      var doc = await db
          .collection('servicos')
          .where('uid', isEqualTo: uid)
          .where('placa', isEqualTo: placa)
          .get();
      ServicosKm servicekm = ServicosKm();
      UserKmModel? userKmModel = await servicekm.getKm(uid, placa);

      if (doc.docs.length == 0) return null;
      var model = UserServiceModel.fromJson(
          doc.docs.first.data(), doc.docs.first.reference);
      List<ServiceModel> servicos = [];
      model.servicos.forEach((element) {
        if (element.data.isBefore(DateTime.now()) ||
            int.parse(element.trocaKm) >= userKmModel!.km) {
          servicos.add(element);
        }
      });

      return servicos;
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }

  Stream<UserServiceModel?> getAtivoStream(String uid, String placa) async* {
    try {
      final doc = db
          .collection('servicos')
          .where('uid', isEqualTo: uid)
          .where('placa', isEqualTo: placa)
          .snapshots();

      // if (doc.length == 0) yield null;
      yield* doc.asyncMap((event) => event.docs.map((service) {
            print(service.data()['servicos']);
            List lista = service.data()['servicos'];
            lista.removeWhere((e) {
              return e['isCompleted'];
            });
            Map<String, dynamic> servico = service.data();
            servico['servicos'] = lista;
            return UserServiceModel.fromJson(servico, service.reference);
          }).toList()[0]);
    } on FirebaseException catch (e) {
      throw AuthError(e.code);
    }
  }
}
