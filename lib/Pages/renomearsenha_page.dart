import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Pages/login_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class RenomearSenhaPage extends StatefulWidget {
  const RenomearSenhaPage({super.key});

  @override
  State<RenomearSenhaPage> createState() => _RenomearSenhaPageState();
}

class _RenomearSenhaPageState extends State<RenomearSenhaPage> {
  final emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                      height: 25,
                      width: 47,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      style: GoogleFonts.comfortaa(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                      'Control Car',
                    ),
                  )
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            // ignore: sort_child_properties_last
            child: Text(
              style: GoogleFonts.comfortaa(
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
              'Recuperar Senha',
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.22,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  onChanged: (text) {},
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      recuperarSenha();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()));
                    },
                    child: const Text('Redefinir Senha'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> recuperarSenha() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }
}
