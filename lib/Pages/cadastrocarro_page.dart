import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CadastroCarroPage extends StatefulWidget {
  @override
  _CadastroCarroPage createState() => _CadastroCarroPage();
}

class _CadastroCarroPage extends State<CadastroCarroPage> {
  bool isSwitched = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

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
                      height: 140,
                      decoration: BoxDecoration(
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
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              style: GoogleFonts.comfortaa(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                              'Carros',
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: IconButton(
                                iconSize: 70,
                                onPressed: () => sendData(),
                                icon: Icon(FontAwesomeIcons.check)),
                          ),
                        ],
                      )),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      color: ThemeApp.cinza,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              child: SizedBox(
                                child: Form(
                                    child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _controllerNome,
                                      decoration:
                                          InputDecoration(labelText: 'Nome'),
                                    ),
                                    TextFormField(
                                      controller: _controllerMarca,
                                      decoration:
                                          InputDecoration(labelText: 'Marca'),
                                    ),
                                    TextFormField(
                                      controller: _controllerModelo,
                                      decoration:
                                          InputDecoration(labelText: 'Modelo'),
                                    ),
                                    TextFormField(
                                      controller: _controllerAno,
                                      decoration:
                                          InputDecoration(labelText: 'Ano'),
                                    ),
                                    TextFormField(
                                      controller: _controllerPlaca,
                                      decoration: InputDecoration(
                                          labelText: 'placa opcional'),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  'Ativo',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: ThemeApp.black,
                                  activeColor: ThemeApp.black,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SizedBox(
                              child: Form(
                                  child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Observação'),
                                  ),
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

  void sendData() {
    String id = Uuid().v1();
    db.collection("carros").doc(id).set({
      "nome": _controllerNome.text,
      "marca": _controllerMarca.text,
      "modelo": _controllerModelo.text,
      "ano": _controllerAno.text,
      "placa": _controllerPlaca.text,
    });
    _controllerNome.text = "";
    _controllerMarca.text = "";
    _controllerModelo.text = "";
    _controllerAno.text = "";
    _controllerPlaca.text = "";
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Carro cadastrado com sucesso!"),
    ));
  }
}
