import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webapp_2024/AppConstant.dart';
import 'package:http/http.dart' as http;

class PaymentService{

  createPayment(String amountVal, String currency) async{
    try{
      Map<String,dynamic> body ={
        "amount": ((int.parse(amountVal)) * 100).toString(),
        "currency": currency,
        'payment_method_types[]':'card',
        'description':'Testing '
      };

      String secretkey = dotenv.env['STRIPE_SECRETKEY']!;
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          "Authorization":"Bearer $secretkey",
          'Content-Type':'application/x-www-form-urlencoded'
        },

      );
return jsonDecode(response.body.toString());
    }
    catch(e){
      print('error $e');
    }

  }


}