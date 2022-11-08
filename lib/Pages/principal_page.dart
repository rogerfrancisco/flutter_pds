import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/configuracao_page.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/Pages/manutecao_page.dart';
import 'package:untitled/Pages/servico_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPage createState() => _PrincipalPage();
}

class _PrincipalPage extends State<PrincipalPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  children: [
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
                                                ConfiguracaoPage()));
                                  },
                                  icon: Icon(CupertinoIcons.gear_solid)),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                      'hoje',
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 126,
                    decoration: BoxDecoration(
                      color: ThemeApp.cinza,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                      'Alerta',
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(color: ThemeApp.red),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                      'Historico',
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(color: ThemeApp.cinza),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Container(
                        child: SizedBox(
                          width: 161,
                          height: 83,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeApp.cinza,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LembretePage()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.alarm_add_sharp,
                                  size: 50,
                                  color: ThemeApp.black,
                                ),
                                Text(
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: ThemeApp.black,
                                  ),
                                  'Lembrete',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 55,
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SizedBox(
                        width: 161,
                        height: 83,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeApp.cinza,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ServicoPage()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.build,
                                size: 50,
                                color: ThemeApp.black,
                              ),
                              Text(
                                style: GoogleFonts.comfortaa(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: ThemeApp.black,
                                ),
                                'Serviço',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
