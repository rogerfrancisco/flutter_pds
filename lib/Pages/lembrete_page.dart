import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/carroview_page.dart';
import 'package:untitled/Pages/lembreteview_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/models/user_service_model.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class LembretePage extends StatefulWidget {
  LembretePage({Key? key, required this.placa}) : super(key: key);

  final String placa;

  @override
  _LembretePage createState() => _LembretePage();
}

class _LembretePage extends State<LembretePage> {
  ServicosService servicosService = ServicosService();
  User? user = FirebaseAuth.instance.currentUser;

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
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
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
                Expanded(
                  flex: 3,
                  child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PrincipalPage(
                                      placa: widget.placa,
                                    )));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: ThemeApp.black,
                      )),
                ),
              ],
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: StreamBuilder(
              stream: servicosService.getAtivoStream(user!.uid, widget.placa),
              builder: (context, AsyncSnapshot<UserServiceModel?> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.servicos.length,
                    itemBuilder: (context, index) {
                      ServiceModel doc = snapshot.data!.servicos[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        color: ThemeApp.cinza,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LembreteViewPage(
                                          serviceModel: doc,
                                          placa: widget.placa,
                                        )));
                          },
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Servi??o:${doc.servico}',
                                    style: getStyle(),
                                  ),
                                  Text(
                                    'km${doc.trocaKm}',
                                    style: getStyle(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.calendarDays),
                                  Text('Data: ${formatarData(doc.data)}',
                                      style: getStyle()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                      'Nenhum servi??o cadastrado',
                    ),
                  );
                }
              }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ]),
    );
  }

  TextStyle getStyle() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.normal,
    );
  }

  String formatarData(DateTime data) {
    return '${data.day}/${data.month}/${data.year}';
    ;
  }
}
