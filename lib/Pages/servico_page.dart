import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/principal_page.dart';
import 'package:untitled/models/auth_error.dart';
import 'package:untitled/models/service_model.dart';
import 'package:untitled/services/servicos_service.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ServicoPage extends StatefulWidget {
  String placa;
  ServicoPage({required this.placa});
  @override
  _ServicoPage createState() => _ServicoPage();
}

class _ServicoPage extends State<ServicoPage> {
  ServicosService servicosService = ServicosService();
  String dropValue = '';
  final dropOpcoes = [
    'Arcondicionado',
    'Balanceamento e geometria',
    'Bateria',
    'Bomba de combustivel',
    'Cinto Segurança',
    'Correias Motor',
    'Escapamento',
    'Filtro de ar motor',
    'Fluido de Freio',
    'Injeção Eletronica',
    'Lampadas',
    'Lataria',
    'Oléo',
    'Pastilhas Freios',
    'Pneus',
    'Radiador',
    'Suspensão'
  ];
  bool isSwitched = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  DateTime data = DateTime.now();
  TextEditingController _dateInput = TextEditingController();
  TextEditingController _timeInput = TextEditingController();
  TextEditingController _trocaKm = TextEditingController();
  TextEditingController _mediaKm = TextEditingController();
  TextEditingController _mecanico = TextEditingController();
  TextEditingController _observacao = TextEditingController();
  List<String> listNames = [];

  @override
  void initState() {
    super.initState();
  }

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
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            flex: 7,
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
                                iconSize: 50,
                                onPressed: () {
                                  sendData();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PrincipalPage(
                                                placa: widget.placa,
                                              )));
                                },
                                icon: const Icon(FontAwesomeIcons.check)),
                          ),
                        ],
                      )),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      color: ThemeApp.cinza,
                      child: Column(
                        children: [
                          SizedBox(
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                icon: const Icon(Icons.build),
                                hint: const Text('Selecione o Serviço'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                onChanged: (escolha) =>
                                    dropValue = escolha.toString(),
                                items: dropOpcoes
                                    .map(
                                      (op) => DropdownMenuItem(
                                        value: op,
                                        child: Text(op),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      height: 33,
                                      child: TextFormField(
                                        controller: _trocaKm,
                                        decoration: const InputDecoration(
                                            hintText: 'Troca KM',
                                            icon: Icon(Icons.speed_outlined)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 130,
                                  height: 33,
                                  child: TextFormField(
                                    controller: _mediaKm,
                                    decoration: const InputDecoration(
                                        hintText: 'Media KM',
                                        icon: Icon(Icons.speed_outlined)),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  child: SizedBox(
                                    width: 130,
                                    height: 30,
                                    child: TextField(
                                      controller: _dateInput,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          hintText: " Data"),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(formattedDate);
                                          setState(() {
                                            data = pickedDate;
                                            _dateInput.text = formattedDate;
                                          });
                                        } else {}
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                Container(
                                  width: 130,
                                  height: 33,
                                  child: TextField(
                                    controller: _timeInput,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.timer),
                                        hintText: "Horario"),
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        String formattedTime =
                                            pickedTime.format(context);
                                        print(formattedTime);
                                        setState(() {
                                          _timeInput.text = formattedTime;
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  controller: _mecanico,
                                  decoration: const InputDecoration(
                                      labelText: 'Mecanico'),
                                ),
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  controller: _observacao,
                                  decoration: const InputDecoration(
                                      labelText: 'Observação'),
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

  void sendData() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      bool value = await servicosService.postService(
        ServiceModel(
          mecanico: _mecanico.text,
          data: data,
          horario: _timeInput.text,
          mediaKm: _mediaKm.text,
          observacao: _observacao.text,
          servico: dropValue,
          trocaKm: _trocaKm.text,
        ),
        user.uid,
        widget.placa,
      );
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Serviço cadastrado com sucesso!"),
        ));
      }
    } on AuthError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }
}
