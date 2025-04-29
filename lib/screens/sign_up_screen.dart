import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var fullNameC = TextEditingController();
  var mobileC = TextEditingController();
  var emailC = TextEditingController();
  var passC = TextEditingController();
  var confirmPassC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.deepOrange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              TextField(
                controller: fullNameC,
                decoration: InputDecoration(
                  hintText: 'Full name',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: mobileC,
                decoration: InputDecoration(
                  hintText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
              ),
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

              TextField(
                obscureText: true,
                controller: confirmPassC,
                decoration: InputDecoration(
                  hintText: 'Confirm Pass',
                  border: OutlineInputBorder(),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  String fullName = fullNameC.text.trim();

                  // if (fullName.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text("Please provide Fullname")),
                  //   );
                  //   return;
                  // }

                  String mobileNum = mobileC.text.trim();
                  String email = emailC.text.trim();
                  String password = passC.text.trim();
                  String confirmPass = confirmPassC.text.trim();

                  // if(password != confirmPass){
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text("Passwords do not match")),
                  //   );
                  //   return;
                  // }

                  FirebaseAuth auth = FirebaseAuth.instance;

                  try{

                    UserCredential userCredentials = await auth.createUserWithEmailAndPassword(email: email, password: password);

                    if( userCredentials.user != null ){

                        Fluttertoast.showToast(msg: 'Success');
                        Navigator.of(context).pop();
                    }
                  } on FirebaseAuthException catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? '')),
                    );

                  }



                  },
                child: const Text("SIGN UP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
