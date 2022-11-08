import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/renomearsenha_page.dart';
import 'package:untitled/main.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    flex: 3,
                    child: Image.asset(
                      'images/logo.png',
                      height: 37,
                      width: 55,
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
          SizedBox(height: 30),
          SizedBox(
            child: Text(
              style: GoogleFonts.comfortaa(
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
              'Login',
            ),
            width: 110,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RenomearSenhaPage()));
                        },
                        child: Text('Esqueci a Senha'),
                      ),
                    )),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: signIn,
                    child: Text('Login'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => CarroPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
        return AlertDialog(
          title: Text("Promoção Imperdivel"),
          content: Text("Não perca a promoção."),
          actions: [
            TextButton(
              child: Text("Disparar"),
              onPressed: () {},
            ),
          ],
        );
      } else if (e.code == 'credential-already-in-use') {
      } else if (e.code == 'internal-error') {
      } else if (e.code == 'invalid-email') {
      } else if (e.code == 'network-request-failed') {}
    }
  }
}
