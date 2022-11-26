import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/services/carros_service.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/store/lembrete_page_store.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/auth_error.dart';

class LembreteViewPage extends StatefulWidget {
  final String placa;
  final ServiceModel serviceModel;

  LembreteViewPage({Key? key, required this.serviceModel, required this.placa})
      : super(key: key);

  @override
  State<LembreteViewPage> createState() => _LembreteViewPageState();
}

class _LembreteViewPageState extends State<LembreteViewPage> {
  final ServicosService servicosService = ServicosService();

  User user = FirebaseAuth.instance.currentUser!;

  FirebaseFirestore db = FirebaseFirestore.instance;

  CarrosService carrosService = CarrosService();

  LembretePageStore store = LembretePageStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => Column(children: [
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 120,
              decoration: const BoxDecoration(
                color: ThemeApp.cinza,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      'images/logo.png',
                      height: 37,
                      width: 55,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                      'Lembrete',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        iconSize: 50,
                        onPressed: () {
                          if (store.isSwitched == true) {
                            confirmeServico(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrincipalPage(placa: widget.placa)));
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.check)),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                padding: const EdgeInsets.all(4),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: ThemeApp.cinza,
                child: ListTile(
                  title: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Mecanico:${widget.serviceModel.mecanico}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            'Data: ${formatarData(widget.serviceModel.data)}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'km: ${widget.serviceModel.trocaKm}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            'Horario: ${widget.serviceModel.horario}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            'MediaKm: ${widget.serviceModel.mediaKm}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            'Serviço: ${widget.serviceModel.servico}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            'Obs: ${widget.serviceModel.observacao}',
                            style: getStyle(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              style: GoogleFonts.comfortaa(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                              'Concluido',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Switch(
                              value: store.isSwitched,
                              onChanged: (value) {
                                store.setSwitched(value);
                              },
                              activeTrackColor: ThemeApp.black,
                              activeColor: ThemeApp.black,
                            ),
                          )
                        ],
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () async {
                                deleteServico(context);
                              },
                              child: const Text('Excluir serviço'),
                            ),
                          )),
                    ],
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  confirmeServico(BuildContext context) {
    Widget cancelaButton = TextButton(
      child: Text("Não"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
        child: Text("Sim"),
        onPressed: () {
          sendData(context);
        });
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirrmação de serviço"),
      content: Text("Deseja confirmar seu serviço?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteServico(BuildContext context) {
    Widget cancelaButton = TextButton(
      child: Text("Não"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
        child: Text("Sim"),
        onPressed: () {
          deleteData(context);
        });
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("excluir serviço"),
      content: Text("Deseja deletar seu serviço?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextStyle getStyle(BuildContext context) {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle getStyle1(BuildContext context) {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w900,
    );
  }

  String formatarData(DateTime data) {
    return '${data.day}/${data.month}/${data.year}';
  }

  void sendData(BuildContext context) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      widget.serviceModel.changecompleted(true);
      var value = await servicosService.updateService(
          widget.serviceModel, user.uid, widget.placa);

      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Serviço atualizado com sucesso"),
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LembretePage(
                      placa: widget.placa,
                    )));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }

  void deleteData(BuildContext context) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      var value = await servicosService.deleteService(
          widget.serviceModel, user.uid, widget.placa);
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Serviço deletado com sucesso"),
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LembretePage(
                      placa: widget.placa,
                    )));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
