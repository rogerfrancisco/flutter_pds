import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastrocarro_page.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/inicial_page.dart';

import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfiguracaoPage extends StatelessWidget {
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
                      onPressed: () {},
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
                        'Configuração',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CarroPage()));
                      },
                      child: Text('Trocar de carro'),
                    ),
                  )),
                  Align(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InicialPage()));
                      },
                      child: Text('Sair'),
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
}
