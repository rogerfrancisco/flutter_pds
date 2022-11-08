import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastrocarro_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class CarroPage extends StatelessWidget {
  List<String> ListaCarros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 120,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PrincipalPage()));
                      },
                      icon: Icon(FontAwesomeIcons.check)),
                ),
              ],
            )),
        SizedBox(height: 20),
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
                  SizedBox(height: 40),
                  SizedBox(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      'Escolha seu Carro',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Carros')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Algo deu errado');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Carregando');
                        }
                        // ignore: unnecessary_new
                        return new ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return ListTile(
                          }).toList(),
                        );
                      },
                    ),
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
        child: const Icon(Icons.add_circle_outline_sharp),
        backgroundColor: ThemeApp.black,
      ),
    );
  }
}
