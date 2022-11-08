import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Pages/login_page.dart';
import 'package:untitled/theme_app.dart';
import 'package:google_fonts/google_fonts.dart';

class CadastroLoginPage extends StatefulWidget {
  const CadastroLoginPage({super.key});

  @override
  State<CadastroLoginPage> createState() => _CadastroLoginPageState();
}

class _CadastroLoginPageState extends State<CadastroLoginPage> {
  final formKey = GlobalKey<FormState>();
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
    return Material(
      child: Form(
        key: formKey,
        child: Column(
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
            SizedBox(height: 50),
            SizedBox(
              child: Text(
                style: GoogleFonts.comfortaa(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
                'Cadastre-se',
              ),
              width: 250,
              height: 80,
            ),
            SizedBox(height: 50),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Digitar um Email Valido'
                            : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    onChanged: (text) {},
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Minimo 6 numeros'
                        : null,
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        signUp();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage()));
                      },
                      child: Text('cadastrar'),
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
