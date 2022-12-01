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

class ServicoPage extends StatefulWidget {
  String placa;
  ServicoPage({required this.placa});
  @override
  _ServicoPage createState() => _ServicoPage();
}

class _ServicoPage extends State<ServicoPage> {
  final formKey = GlobalKey<FormState>();
  ServicosService servicosService = ServicosService();
  String dropValue = '';
  final dropOpcoes = [
    'Arcondicionado',
    'Balanceamento',
    'Bateria',
    'Bomba de combustivel',
    'Cinto Segurança',
    'Correias Motor',
    'Escapamento',
    'Filtro de ar motor',
    'Fluido de Freio',
    'Geometria',
    'Injeção Eletronica',
    'Lampadas',
    'Lataria',
    'Oléo',
    'Pastilhas Freios',
    'Pneus',
    'Radiador',
    'Suspensão',
    'Outros'
  ];
  bool isSwitched = true;
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
                                  if (formKey.currentState!.validate()) {
                                    sendData();
                                    Navigator.pop(context);
                                  }
                                },
                                icon: const Icon(FontAwesomeIcons.check)),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      color: ThemeApp.cinza,
                      child: Column(
                        children: [
                          SizedBox(
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                autovalidateMode: AutovalidateMode.always,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Obrigatório';
                                  }
                                },
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          SizedBox(
                            child: Form(
                                key: formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.32,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: TextFormField(
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Obrigatório';
                                              }
                                            },
                                            controller: _trocaKm,
                                            decoration: const InputDecoration(
                                                hintText: 'Troca KM',
                                                icon:
                                                    Icon(Icons.speed_outlined)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.37,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return ' Obrigatório';
                                        }
                                      },
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
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
          isCompleted: false,
        ),
        user.uid,
        widget.placa,
      );
      if (value) {
        // ignore: use_build_context_synchronously
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
