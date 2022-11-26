import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastrocarro_page.dart';

import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/carroview_page.dart';

import 'package:untitled/Pages/inicial_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/Pages/relatorio_page.dart';
import 'package:untitled/models/auth_error.dart';
import 'package:untitled/services/servicos_service.dart';

import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_carro_model.dart';
import '../services/carros_service.dart';

class ConfiguracaoPage extends StatefulWidget {
  ConfiguracaoPage({Key? key, required this.placa}) : super(key: key);

  final String placa;
  _ConfiguracaoPage createState() => _ConfiguracaoPage();
}

class _ConfiguracaoPage extends State<ConfiguracaoPage> {
  CarrosService carrosService = CarrosService();

  User user = FirebaseAuth.instance.currentUser!;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static var carroModel;
  ServicosService servicosService = ServicosService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.15,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: ThemeApp.cinza,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'images/logo.png',
                    height: 37,
                    width: 55,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    style: GoogleFonts.comfortaa(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                    'Configuração',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PrincipalPage(placa: widget.placa),
                          ),
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.arrowLeft)),
                ),
              ],
            )),
        SizedBox(width: MediaQuery.of(context).size.width * 0.09),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              color: ThemeApp.cinza,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        style: GoogleFonts.comfortaa(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                        'Configuração',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CarroPage()));
                      },
                      child: const Text('Trocar de Veiculo'),
                    ),
                  )),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => CarroView(
                                      placa: widget.placa,
                                    )));
                      },
                      child: const Text('Deletar Veiculo'),
                    ),
                  )),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RelatorioPage(
                                      placa: widget.placa,
                                    )));
                      },
                      child: const Text('Visualizar Serviços Realizados'),
                    ),
                  )),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        signOut(context);
                      },
                      child: const Text('sair'),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => InicialPage()));
    } on FirebaseAuthException catch (e) {
      AuthError authError = AuthError(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authError.message),
        ),
      );
    }
  }
}
