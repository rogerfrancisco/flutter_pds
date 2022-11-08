import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/lembreteview_page.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/models/user_service_model.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class LembretePage extends StatefulWidget {
  LembretePage({Key? key, required this.placa}) : super(key: key);

  String placa;

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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: FutureBuilder(
              future: servicosService.getService(user!.uid, widget.placa),
              builder: (context, AsyncSnapshot<UserServiceModel?> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.servicos.length,
                    itemBuilder: (context, index) {
                      ServiceModel doc = snapshot.data!.servicos[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        color: ThemeApp.cinza,
                        child: ListTile(
                          onLongPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LembreteViewPage(
                                          serviceModel: doc,
                                        )));
                          },
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    doc.servico,
                                    style: getStyle(),
                                  ),
                                  Text(
                                    'km' + doc.trocaKm,
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
                                  Text('Data: ' + formatarData(doc.data),
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
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        SizedBox(height: 10),
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
    return data.day.toString() +
        '/' +
        data.month.toString() +
        '/' +
        data.year.toString();
    ;
  }
}
