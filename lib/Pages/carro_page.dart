import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastrocarro_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/services/carros_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/carro_model.dart';
import '../models/user_carro_model.dart';

class CarroPage extends StatefulWidget {
  @override
  _CarroPage createState() => _CarroPage();
}

class _CarroPage extends State<CarroPage> {
  CarrosService carrosService = CarrosService();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
              ],
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
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
                        'Seja Bem-vindo \nControl Car',
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Image.asset(
                      'images/carro.png',
                      height: 106,
                      width: 152,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      'Escolha seu Carro',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: StreamBuilder(
                        stream: carrosService.getStream(user.uid),
                        builder:
                            (context, AsyncSnapshot<UserCarroModel?> snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: DropdownButtonFormField(
                                  icon: const Icon(
                                    Icons.car_crash_outlined,
                                    size: 40,
                                  ),
                                  items: List<DropdownMenuItem>.from(snapshot
                                      .data!.carros
                                      .map((x) => DropdownMenuItem(
                                            value: x.placa,
                                            child: Text(x.marca + x.modelo,
                                                style: getStyle()),
                                          ))),
                                  onChanged: (value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PrincipalPage(
                                                  placa: value,
                                                )));
                                  }),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CadastroCarroPage()));
        },
        backgroundColor: ThemeApp.black,
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }

  TextStyle getStyle() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.normal,
    );
  }
}
