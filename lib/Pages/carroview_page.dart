import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/configuracao_page.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/Pages/servico_page.dart';
import 'package:untitled/models/carro_model.dart';
import 'package:untitled/models/user_carro_model.dart';
import 'package:untitled/models/user_km_model.dart';
import 'package:untitled/services/carros_service.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/models/km_model.dart';
import 'package:untitled/services/km_service.dart';
import '../models/auth_error.dart';
import '../models/service_model.dart';
import '../models/user_service_model.dart';
import 'lembreteview_page.dart';

class CarroView extends StatefulWidget {
  CarroView({Key? key, required this.placa}) : super(key: key);

  final String placa;
  @override
  _CarroView createState() => _CarroView();
}

class _CarroView extends State<CarroView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CarrosService carrosService = CarrosService();

  User user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _controllerKm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Column(
                    children: [
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
                                flex: 3,
                                child: Image.asset(
                                  'images/logo.png',
                                  height: 34,
                                  width: 50,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  'Control Car',
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
                                              builder: (BuildContext context) =>
                                                  ConfiguracaoPage(
                                                      placa: widget.placa)));
                                    },
                                    icon:
                                        const Icon(FontAwesomeIcons.arrowLeft)),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        style: GoogleFonts.comfortaa(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                        'Selecione o veiculo \npara excluir',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: FutureBuilder(
                        future: carrosService.getCarro(
                          user.uid,
                        ),
                        builder:
                            (context, AsyncSnapshot<UserCarroModel?> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.carros.length,
                                itemBuilder: (context, index) {
                                  CarroModel carro =
                                      snapshot.data!.carros[index];
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 25),
                                    color: ThemeApp.cinza,
                                    child: ListTile(
                                      onTap: () async {
                                        confirmeDelete(context, carro);
                                      },
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                carro.modelo +
                                                    ' ' +
                                                    carro.marca,
                                                style: getStyle(),
                                              ),
                                              Text(
                                                'Ano${carro.ano}',
                                                style: getStyle(),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  FontAwesomeIcons.carSide),
                                              Text(
                                                  ' ' +
                                                      'Placa: ${(carro.placa)}',
                                                  style: getStyle()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ]))));
  }

  confirmeDelete(BuildContext context, CarroModel carro) {
    Widget cancelaButton = TextButton(
      child: Text("Não"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Sim"),
      onPressed: () async {
        bool status = await carrosService.deleteCarro(carro, user.uid);

        if (status) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Veiculo deletado com sucesso'),
              backgroundColor: Colors.black,
            ),
          );
          setState(() {});
        }
        Navigator.of(context).pop();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Excluir Veiculo"),
      content: Text("Deseja Excluir seu Veiculo?"),
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

  TextStyle getStyle() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w900,
    );
  }
}
