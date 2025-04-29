
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uop_todo_day5/screens/dashboard_screen.dart';
import 'package:uop_todo_day5/screens/email_verification_screen.dart';
import 'package:uop_todo_day5/screens/forgot_password_screen.dart';
import 'package:uop_todo_day5/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailC = TextEditingController();
  var passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        // backgroundColor: Colors.deepOrange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(

            spacing: 10,
            children: [

              TextField(
                controller: emailC,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                obscureText: true,
                controller: passC,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              TextButton(

                  onPressed: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ForgotPasswordScreen();
                    }));
                  }, child: const Text('Forgot Password?', textAlign: TextAlign.end,)),

              ElevatedButton(onPressed: () async {
                String email = emailC.text.trim();
                String password = passC.text.trim();

                FirebaseAuth auth = FirebaseAuth.instance;

                try{
                  UserCredential userCredentials =  await auth.signInWithEmailAndPassword(email: email, password: password);

                  if( userCredentials.user != null ){
                    Fluttertoast.showToast( msg: 'success');
                    // first check if email is verified

                    if( !userCredentials.user!.emailVerified){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return EmailVerificationScreen();
                      }));
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DashboardScreen();
                      }));
                    }

                    // Navigate to Dashboard
                  }
                } on FirebaseAuthException catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? '')),
                  );
                }

              }, child: const Text("LOGIN")),


              TextButton(

                  onPressed: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return SignUpScreen();
                    }));
                  }, child: const Text('Not Registered Yet? SIGN UP', textAlign: TextAlign.end,)),

            ],
          ),
        ),
      ),
    );
  }
}
