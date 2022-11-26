import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/models/carro_model.dart';
import 'package:untitled/services/carros_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/auth_error.dart';

class CadastroCarroPage extends StatefulWidget {
  @override
  _CadastroCarroPage createState() => _CadastroCarroPage();
}

class _CadastroCarroPage extends State<CadastroCarroPage> {
  CarrosService carrosService = CarrosService();
  bool isSwitched = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerMarca = TextEditingController();
  TextEditingController _controllerAno = TextEditingController();
  TextEditingController _controllerModelo = TextEditingController();
  TextEditingController _controllerPlaca = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Column(children: [
                  Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
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
                            width: 40,
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              style: GoogleFonts.comfortaa(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                              'Veiculos',
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: IconButton(
                                iconSize: 60,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    sendData();
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CarroPage()));
                                },
                                icon: const Icon(FontAwesomeIcons.check)),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      color: ThemeApp.cinza,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SizedBox(
                              child: Form(
                                  key: formKey,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          //return null;
                                        },
                                        controller: _controllerPlaca,
                                        decoration: const InputDecoration(
                                            labelText: 'Placa'),
                                      ),
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          //return null;
                                        },
                                        controller: _controllerMarca,
                                        decoration: const InputDecoration(
                                            labelText: 'Marca'),
                                      ),
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          //return null;
                                        },
                                        controller: _controllerModelo,
                                        decoration: const InputDecoration(
                                            labelText: 'Modelo'),
                                      ),
                                      TextFormField(
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          //return null;
                                        },
                                        controller: _controllerAno,
                                        decoration: const InputDecoration(
                                            labelText: 'Ano'),
                                      ),
                                      TextFormField(
                                        controller: _controllerNome,
                                        decoration: const InputDecoration(
                                            labelText: 'Nome opcional'),
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Observação'),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendData() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      bool value = await carrosService.postCarro(
        CarroModel(
          nome: _controllerNome.text,
          marca: _controllerMarca.text,
          modelo: _controllerModelo.text,
          ano: _controllerAno.text,
          placa: _controllerPlaca.text,
        ),
        user.uid,
      );
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Veiculo cadastrado com sucesso!"),
        ));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
