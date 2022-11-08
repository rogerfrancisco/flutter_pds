import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastrocarro_page.dart';
import 'package:untitled/Pages/cadastrolembrete.dart';

import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class LembretePage extends StatelessWidget {
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
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    style: GoogleFonts.comfortaa(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                    'Lembrete',
                  ),
                ),
              ],
            )),
        SizedBox(height: 20),
        Row(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CadastroLembretePage()));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
        backgroundColor: ThemeApp.black,
      ),
    );
  }
}
