import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:untitled/Pages/carro_page.dart';
import 'package:untitled/Pages/renomearsenha_page.dart';
import 'package:untitled/models/auth_error.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
                'Login',
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RenomearSenhaPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Esqueceu a Senha?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: signIn,
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => CarroPage()));
    } on FirebaseAuthException catch (e) {
      AuthError error = AuthError(e.code);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
      ));
    }
  }
}
