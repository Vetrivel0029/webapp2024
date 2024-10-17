import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberOtp extends StatefulWidget {
  const PhoneNumberOtp({super.key});

  @override
  State<PhoneNumberOtp> createState() => _PhoneNumberOtpState();
}

class _PhoneNumberOtpState extends State<PhoneNumberOtp> {
  final TextEditingController numberController = TextEditingController();

Future<void> sendOTP(String? number) async{
   await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: number,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {},
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 250,),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: textformField(),
        ),
        SizedBox(height: 20,),
        button(),
      ],
    );
  }

  Widget textformField(){
    return TextFormField(
      controller: numberController,
      decoration: const InputDecoration(
        hintText: "Enter your mobile number",
        border: OutlineInputBorder(),
        label: Text("Enter the Number")

      ),
    );
  }

  Widget button(){
    return ElevatedButton(onPressed: (){
      sendOTP(numberController.text);
    }, child: Text("CLick"));
  }
}
