import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Pages/cadastromanutencao_page.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/servico_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class ManutencaoPage extends StatefulWidget {
  @override
  _ManutencaoPage createState() => _ManutencaoPage();
}

class _ManutencaoPage extends State<ManutencaoPage> {
  bool isSwitched = false;
  bool ar = false;
  bool ba = false;
  bool bat = false;
  bool bom = false;
  bool cin = false;
  bool co = false;
  bool es = false;
  bool fi = false;
  bool flu = false;
  bool inj = false;
  bool la = false;
  bool lat = false;
  bool ol = false;
  bool pas = false;
  bool pne = false;
  bool rad = false;
  bool sus = false;

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
                            flex: 2,
                            child: Image.asset(
                              'images/logo.png',
                              height: 37,
                              width: 55,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              style: GoogleFonts.comfortaa(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                              ),
                              'Manutenção',
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                iconSize: 70,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ServicoPage()));
                                },
                                icon: Icon(FontAwesomeIcons.check)),
                          ),
                        ],
                      )),
                  SizedBox(height: 30),
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
                            child: Column(
                              children: [
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: ar,
                                    onChanged: (value) {
                                      setState(() => ar = value!);
                                    },
                                    title: Text('Arcondicionado'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 37,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: ba,
                                    onChanged: (value) {
                                      setState(() => ba = value!);
                                    },
                                    title: Text('Balanceamento e geometria'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: bat,
                                    onChanged: (value) {
                                      setState(() => bat = value!);
                                    },
                                    title: Text('Bateria'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 37,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: bom,
                                    onChanged: (value) {
                                      setState(() => bom = value!);
                                    },
                                    title: Text('Bomba de Combustivel'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: cin,
                                    onChanged: (value) {
                                      setState(() => cin = value!);
                                      Navigator.push(
                                          context, //
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ServicoPage()));
                                    },
                                    title: Text('Cinto Segurança'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: co,
                                    onChanged: (value) {
                                      setState(() => co = value!);
                                    },
                                    title: Text('Correias Motor'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: es,
                                    onChanged: (value) {
                                      setState(() => es = value!);
                                    },
                                    title: Text('Escapamento'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: fi,
                                    onChanged: (value) {
                                      setState(() => fi = value!);
                                    },
                                    title: Text('Filtro ar motor'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: flu,
                                    onChanged: (value) {
                                      setState(() => flu = value!);
                                    },
                                    title: Text('Fluido Freio'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 37,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: inj,
                                    onChanged: (value) {
                                      setState(() => inj = value!);
                                    },
                                    title: Text('Injeção Eletronica'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: la,
                                    onChanged: (value) {
                                      setState(() => la = value!);
                                    },
                                    title: Text('Lâmpadas'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: lat,
                                    onChanged: (value) {
                                      setState(() => lat = value!);
                                    },
                                    title: Text('Lataria'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: ol,
                                    onChanged: (value) {
                                      setState(() => ol = value!);
                                    },
                                    title: Text('Oléo'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: pas,
                                    onChanged: (value) {
                                      setState(() => pas = value!);
                                    },
                                    title: Text('Pastilhas Freios'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: pne,
                                    onChanged: (value) {
                                      setState(() => pne = value!);
                                    },
                                    title: Text('Pneus'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: rad,
                                    onChanged: (value) {
                                      setState(() => rad = value!);
                                    },
                                    title: Text('Radiador'),
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 80,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: sus,
                                    onChanged: (value) {
                                      setState(() => sus = value!);
                                    },
                                    title: Text('Suspensão'),
                                  ),
                                ),
                              ],
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CadastroManutencaoPage()));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
        backgroundColor: ThemeApp.black,
      ),
    );
  }
}
