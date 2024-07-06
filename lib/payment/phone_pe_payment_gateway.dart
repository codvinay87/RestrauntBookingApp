import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePeScreen extends StatefulWidget {
  final int amount;
  const PhonePeScreen({super.key,required this.amount});

  @override
  State<PhonePeScreen> createState() => _PhonePeScreenState();

}

class _PhonePeScreenState extends State<PhonePeScreen> {
  String environmentValue = 'UAT_SIM';
  String appId="";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checksum="";
  String saltKey="099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex="1";
  String callbackUrl = "www.google.com";
  String body="";
  Object? result;
  // String apiEndPoint = "https://api-preprod.phonepe.com/apis/pg-sandbox";
  String apiEndPoint = "/pg/v1/pay";

  getCheckSum(){
    final requestData = {
  "merchantId": merchantId,
  "merchantTransactionId": "MT7850590068188104",
  "merchantUserId": "MUID123",
  "amount": widget.amount,
  "callbackUrl": callbackUrl,
  "mobileNumber": "9999999999",
  "paymentInstrument": {
    "type": "PAY_PAGE"

  }
    };
  String base64Body=base64.encode(utf8.encode(json.encode(requestData)));
  checksum = "${sha256.convert(utf8.encode(base64Body + apiEndPoint+saltKey)).toString()}###$saltIndex";

    return checksum;
  }
  
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phonepeInit();
    body = getCheckSum().toString();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Pe Payment Gateway")),
      body:
      Column(
        children:[ 
      ElevatedButton(
        onPressed: () {
          startTransaction();
        } ,
        child: Text("Start Transaction of ${widget.amount}"),
        ),
        Text("Result:\n  $result"),
        ]
        ),

    );
  }
  void phonepeInit(){
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }
  
  void startTransaction() async{
    print(body);
    print(checksum);

    var response = PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "",).then((response) => {
    setState(() {
                   if (response != null) 
                        {
                           String status = response['status'].toString();
                           String error = response['error'].toString();
                           if (status == 'SUCCESS') 
                           {
                             result = "Flow Completed - Status: Success!";
                           } 
                           else {
                           result =  "Flow Completed - Status: $status and Error: $error";
                           }
                        } 
                   else {
                          // "Flow Incomplete";
                        }
                })
  }).catchError((error) {
  // handleError(error)
  return <dynamic>{};
  });
  }
  void handleError(error) {
    setState(() {
      result={"error":error};
    });
  }
}