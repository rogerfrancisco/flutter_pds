import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/configuracao_page.dart';
import 'package:untitled/Pages/lembrete_page.dart';
import 'package:untitled/Pages/servico_page.dart';
import 'package:untitled/models/user_km_model.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/store/principal_page_store.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/models/km_model.dart';
import 'package:untitled/services/km_service.dart';
import '../models/auth_error.dart';
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
  PrincipalPageStore store = PrincipalPageStore();

  ServicosKm kmService = ServicosKm();
  bool isSwitched = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  ServicosService servicosService = ServicosService();
  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _controllerKm = TextEditingController();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.15,
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
                              flex: 6,
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
                                                ConfiguracaoPage(
                                                  placa: widget.placa,
                                                )));
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
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.10,
                          decoration: const BoxDecoration(
                            color: ThemeApp.cinza,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextFormField(
                                  controller: _controllerKm,
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
                                              0.03,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  iconSize: 70,
                                  onPressed: () {
                                    if (_controllerKm.text == '') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Erro'),
                                              content: const Text(
                                                  'Insira um valor válido'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Ok'),
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      sendData();
                                    }
                                  },
                                  // ignore: prefer_const_constructors
                                  icon: Icon(CupertinoIcons
                                      .checkmark_alt_circle_fill)),
                              IconButton(
                                  iconSize: 70,
                                  onPressed: () {
                                    showAlertkm(context);
                                  },
                                  // ignore: prefer_const_constructors
                                  icon: Icon(CupertinoIcons
                                      .arrow_clockwise_circle_fill)),
                            ],
                          )),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: StreamBuilder(
                                stream: kmService.getKmStream(
                                    user!.uid, widget.placa),
                                builder: (context,
                                    AsyncSnapshot<UserKmModel?> snapshot) {
                                  if (snapshot.hasData) {
                                    store.setKm(snapshot.data?.km ?? 0);
                                    if (snapshot.data == null) {
                                      return const Text(
                                        'Nenhuma KM registrada',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'KM Atual: ${snapshot.data!.km}',
                                        style: GoogleFonts.comfortaa(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      );
                                    }
                                  } else {
                                    return const Text('Km não informada');
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: ThemeApp.red,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: SingleChildScrollView(
                          child: StreamBuilder(
                              stream: servicosService.getAtivoStream(
                                  user!.uid, widget.placa),
                              builder: (context,
                                  AsyncSnapshot<UserServiceModel?> snapshot) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text('ALERTA', style: getStyle1()),
                                    snapshot.data != null &&
                                            snapshot.data!.servicos.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.servicos.length,
                                            itemBuilder: (context, index) {
                                              ServiceModel doc = snapshot
                                                  .data!.servicos[index];
                                              return ListTile(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              LembretePage(
                                                                placa: widget
                                                                    .placa,
                                                              )));
                                                },
                                                title: Column(
                                                  children: [
                                                    Text(
                                                      'Serviço:${doc.servico}',
                                                      style: getStyle(),
                                                    ),
                                                    Text(
                                                      doc.data.isBefore(
                                                              DateTime.now())
                                                          ? 'Data atrasada,troca urgente!'
                                                          : 'Vence em ${doc.data.difference(DateTime.now()).inDays + 1} dia',
                                                      style: getStyle2(),
                                                    ),
                                                    Text(
                                                      int.parse(doc.trocaKm) >=
                                                              store.km
                                                          ? 'Faltam ${int.parse(doc.trocaKm) - store.km} KM para a troca'
                                                          : 'Km ultrapassado,troca urgente!',
                                                      style: getStyle2(),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Text(
                                            'Nenhum serviço informado',
                                            style: getStyle(),
                                          ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
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
                              width: MediaQuery.of(context).size.width * 0.36,
                              height: MediaQuery.of(context).size.height * 0.10,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.36,
                          height: MediaQuery.of(context).size.height * 0.10,
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
                                const Icon(
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendData() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      bool value = await kmService.postKm(
        int.parse(_controllerKm.text.trim()),
        user.uid,
        widget.placa,
      );
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Km cadastrado com sucesso!"),
        ));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  showAlertkm(BuildContext context) {
    // configura o button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        bool value =
            await kmService.updateKm(KmModel(km: 0), user!.uid, widget.placa);

        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Km zerada com sucesso!"),
      content: Text("Insira o Km novamente"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  TextStyle getStyle() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.06,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle getStyle1() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.08,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle getStyle2() {
    return GoogleFonts.comfortaa(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w900,
    );
  }

  String formatarData(DateTime data) {
    return '${data.day}/${data.month}/${data.year}';
    ;
  }
}
