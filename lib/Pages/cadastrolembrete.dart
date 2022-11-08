import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class CadastroLembretePage extends StatelessWidget {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LembretePage()));
                      },
                      icon: Icon(FontAwesomeIcons.check)),
                ),
              ],
            )),
        SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: SizedBox(
                    child: Form(
                        child: Column(
                      children: [
                        TextFormField(
                          style: GoogleFonts.comfortaa(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Tipo de Manutenção',
                          ),
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
    );
  }
}
