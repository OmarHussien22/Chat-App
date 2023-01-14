import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/constants.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                Row(
                  children: const [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                    onchange: (data) {
                      email = data;
                    },
                    hintText: 'Email'),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                    obscureText: true,
                    onchange: (data) {
                      password = data;
                    },
                    hintText: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoding = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatScreen.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (ex.code == 'worng-password') {
                          showSnackBar(context, 'worng password');
                        }
                      } catch (ex) {
                        print(ex);
                        showSnackBar(context, 'there was an error');
                      }

                      isLoding = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account:',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, RegisterPage.id);
                      }),
                      child: const Text(
                        ' Register',
                        style: TextStyle(color: Colors.white, fontSize: 17),
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
