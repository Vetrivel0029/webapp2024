import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:webapp_2024/AppConstant.dart';
import 'package:webapp_2024/payment_page.dart';
import 'package:webapp_2024/phone_number_otp.dart';

import 'SignIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env['PUBLISH_KEY']!;
  await Stripe.instance.applySettings();
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';

  await Firebase.initializeApp(
    // name: '[DEFAULT]',
    // options: const FirebaseOptions(apiKey: 'AIzaSyBpmN4JFbTHHZWwqAkw77FCV9Z-YUmGi3U',
    //     appId: '1:174273605486:android:f44241db477123de8d1b7f', messagingSenderId: '174273605486', projectId: 'webapp2024-301fc')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> pageTitle =["SignIn Page", "OTP Page",'Payment Page'];

  final List<Widget> pages =[
    const SignIn(),
    const PhoneNumberOtp(),
    const PaymentPage(),

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
        title: Text(pageTitle[2]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pages[2],
          ],
        ),
      ),
    );
  }
}

