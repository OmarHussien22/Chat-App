import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/login_app.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterPage.id: (context) => const RegisterPage(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
    );
  }
}
