// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import "package:http/http.dart" as http;
class FacebookAuthService{
  signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    // final graphResponse = await http.get(Uri.parse(
    // 'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.tokenString}'));
    // final profile  = jsonDecode(graphResponse.body);
    if(result.status==LoginStatus.success){
      
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        return FirebaseAuth.instance.signInWithCredential(credential);
    
    }
  } 
}