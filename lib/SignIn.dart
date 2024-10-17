import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
var list;
  Future<UserCredential?> signInGoogle() async{

final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount!.authentication;
final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication!.accessToken,
idToken:googleSignInAuthentication.idToken
);
final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
print("UserCredential ${userCredential.credential}");
print("UserCredential ${userCredential.user}");
print("UserCredential ${userCredential.additionalUserInfo}");
print("email ${userCredential.user!.email}");
print("UserCredential ${userCredential.user!.displayName}");
print("UserCredential ${userCredential.user!.metadata}");
print("UserCredential ${userCredential.user!.tenantId}");


  }




  // Future<dynamic> signOut()async{
  //   await _googleSignIn.signOut();
  // }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 250,),
        Center(
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.greenAccent)
            ),
            onPressed: (){
              signInGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(Icons.g_mobiledata,size: 60,),
                const Text('Sign In',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,

                  ),),

              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Center(
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent)
            ),
            onPressed: () async{
              // await FirebaseAuth.instance.signOut();
              await _googleSignIn.signOut();
              setState(() {

              });



            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.g_mobiledata,size: 60,),
                Text('Sign Out',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,

                  ),)
              ],
            ),
          ),
        ),
        // Container(
        //   color: Colors.greenAccent,
        //   child: Text(list),
        // )
      ],
    );
  }
}
