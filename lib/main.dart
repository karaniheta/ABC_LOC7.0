import 'package:amburush/emergency/emergency.dart';
import 'package:amburush/firebase_options.dart';
import 'package:amburush/local_string.dart';
//import 'package:amburush/payment.dart';
// import 'package:amburush/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Emergency(),
      translations: LocalString(),
      locale: Locale('en','US'),
      
    );
  }
}
