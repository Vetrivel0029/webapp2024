import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:local_auth/local_auth.dart';
import 'package:webapp_2024/payment_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? paymentIntent;
  PaymentService paymentService =PaymentService();
  final LocalAuthentication auth = LocalAuthentication();
   bool? canAuthenticate;

  Future<bool> lockPattern() async{
    // final res = await auth.canCheckBiometrics;
    //
    // setState(() {
    //   canAuthenticate = res;
    // });


     final res = await auth.authenticate(
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true
        ),
        localizedReason:"Please enter the valid pattern");
    print("canCheckBiometrics $res");
    setState(() {
      canAuthenticate = res;
    });
     canAuthenticate = res;
    return res;
  }


  Future<void> makePay()async{
try{
  paymentIntent =
  await paymentService.createPayment('1', "INR");
print("paymentIntent!['customer'] ${paymentIntent!['customer']}");
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters:SetupPaymentSheetParameters(
    paymentIntentClientSecret: paymentIntent!['client_secret'],
      merchantDisplayName: 'AGM',
    customFlow: false,
    customerId: paymentIntent!['customer'],
    googlePay: const PaymentSheetGooglePay(
      testEnv: true,
        currencyCode: 'INR',
        merchantCountryCode: 'IN'),

   ),

  );
  displayPaymentSheet();
}
    catch(e){
  print(e);
    }
  }

  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Successfully!!!!")));
    } on StripeException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid Cancel!!!!")));
    }
        catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Failed !!!!")));
        }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    canAuthenticate =false;
    print("canCheckBiometrics $canAuthenticate");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 250,),
        Center(
          child: ElevatedButton(onPressed: () {
            makePay();

          }, child: Text("Pay")),
        ),
        Center(
          child: ElevatedButton(onPressed: (){
            lockPattern();
          }, child: Icon(canAuthenticate! == false ?Icons.lock: Icons.lock_open_rounded)),
        )
      ],
    );
  }
}
