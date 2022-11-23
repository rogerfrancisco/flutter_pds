import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/auth_error.dart';

class LembreteViewPage extends StatelessWidget {
  final String placa;
  final ServiceModel serviceModel;

  final ServicosService servicosService = ServicosService();
  LembreteViewPage({Key? key, required this.serviceModel, required this.placa})
      : super(key: key);

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                        Navigator.pop(context);
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: ThemeApp.cinza,
              child: ListTile(
                title: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Mecanico:${serviceModel.mecanico}',
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
                          'Data: ${formatarData(serviceModel.data)}',
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
                          'km: ${serviceModel.trocaKm}',
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
                          'Horario: ${serviceModel.horario}',
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
                          'Media: ${serviceModel.mediaKm}',
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
                          'Serviço: ${serviceModel.servico}',
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
                          'Obs: ${serviceModel.observacao}',
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
                            value: isSwitched,
                            onChanged: (value) {
                              sendData(value, context);
                            },
                            activeTrackColor: ThemeApp.black,
                            activeColor: ThemeApp.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }

  TextStyle getStyle(BuildContext context) {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.07,
      fontWeight: FontWeight.w900,
    );
  }

  String formatarData(DateTime data) {
    return '${data.day}/${data.month}/${data.year}';
  }

  void sendData(bool confirmado, BuildContext context) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      serviceModel.changecompleted(confirmado);
      var value =
          await servicosService.updateService(serviceModel, user.uid, placa);

      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Serviço atualizado com sucesso"),
        ));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
