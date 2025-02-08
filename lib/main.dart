
import 'package:amburush/auth/login.dart';
<<<<<<< Updated upstream
=======
import 'package:amburush/bottomnav/bottom_navbar.dart';
import 'package:amburush/dashboard.dart';
>>>>>>> Stashed changes
import 'package:amburush/firebase_options.dart';
// import 'package:amburush/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  runApp(AmbuRushApp());
}

class AmbuRushApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
    
    debugShowCheckedModeBanner: false,
      home: LoginPage(),
=======
      title: 'AmbuRush',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Dashboard(),
>>>>>>> Stashed changes
    );
  }
}

