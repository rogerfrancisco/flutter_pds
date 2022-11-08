import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicoPage extends StatefulWidget {
  @override
  _ServicoPage createState() => _ServicoPage();
}

class _ServicoPage extends State<ServicoPage> {
  bool isSwitched = false;

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
                              'Serviços',
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
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      color: ThemeApp.cinza,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Tipo de Serviços'),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 33,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Troca KM'),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Container(
                                  width: 130,
                                  height: 33,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Media KM'),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 33,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Data'),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Container(
                                  width: 130,
                                  height: 33,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Hora'),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Mecanico'),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Observação'),
                                ),
                              ],
                            )),
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
}
