import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/configuracao_page.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/Pages/servico_page.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/service_model.dart';
import '../models/user_service_model.dart';
import 'lembreteview_page.dart';

class PrincipalPage extends StatefulWidget {
  String placa;
  PrincipalPage({required this.placa});

  @override
  _PrincipalPage createState() => _PrincipalPage();
}

class _PrincipalPage extends State<PrincipalPage> {
  ServicosService servicosService = ServicosService();
  User? user = FirebaseAuth.instance.currentUser;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 140,
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
                                              ConfiguracaoPage()));
                                },
                                icon: const Icon(CupertinoIcons.gear_solid)),
                          ),
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: const BoxDecoration(
                          color: ThemeApp.cinza,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.comfortaa(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.1,
                                  fontWeight: FontWeight.w900,
                                ),
                                decoration: InputDecoration(
                                  focusColor: ThemeApp.cinza,
                                  labelText: 'Insira a KM Atual',
                                  labelStyle: GoogleFonts.comfortaa(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {},
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                    CupertinoIcons.checkmark_alt_circle_fill)),
                          ],
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: ThemeApp.red,
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: FutureBuilder(
                      future:
                          servicosService.getAlerta(user!.uid, widget.placa),
                      builder: (context,
                          AsyncSnapshot<List<ServiceModel>?> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ServiceModel doc = snapshot.data![index];
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: ListTile(
                                  title: SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          doc.servico +
                                              ' ' +
                                              formatarData(doc.data),
                                          style: getStyle(),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
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
                                            LembretePage(
                                              placa: widget.placa,
                                            )));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
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
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        child: SizedBox(
                          width: 151,
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
                                          ServicoPage(
                                            placa: widget.placa,
                                          )));
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
      ),
    );
  }

  TextStyle getStyle() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w900,
    );
  }

  String formatarData(DateTime data) {
    return data.day.toString() +
        '/' +
        data.month.toString() +
        '/' +
        data.year.toString();
    ;
  }
}
