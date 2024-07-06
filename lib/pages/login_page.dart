import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restraunt_booking_app_easemydeal/pages/signup_page.dart';
import 'package:restraunt_booking_app_easemydeal/services/auth_service.dart';
import 'package:restraunt_booking_app_easemydeal/services/facebook_auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';




class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      errorMessage(e.code);
    }

  }
  void errorMessage(String message){
     showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
             message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong email message popup
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 26, 18, 63),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
            
                // logo
                const Icon(
                  Icons.local_restaurant_outlined,
                  size: 100,
                  color: Colors.white,
                ),
            
                const SizedBox(height: 50),
            
                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),
            
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // sign in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),
            
                const SizedBox(height: 50),
            
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 50),
            
                // google + apple sign in buttons

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signinWithGoogle(),
                      imagePath: 'lib/images/google.png'
                      ),
            
                    const SizedBox(width: 25),
                    
                    // apple button
                    SquareTile(
                      onTap: ()=>FacebookAuthService().signInWithFacebook(),
                      imagePath: 'lib/images/Facebook_logo.png'
                      )
                  ],
                ),
            
                const SizedBox(height: 50),
              
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                     TextButton(
                      onPressed: widget.onTap,
                      
                      child: const Text('Register now',  style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),),
                    
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
