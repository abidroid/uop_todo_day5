
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uop_todo_day5/screens/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        // backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(onPressed: (){

            showDialog(context: context, builder: (context){
              return AlertDialog(

               title: Text("Confirmation"),
               content: Text("Are you sure to Logout?"),
               actions: [
                 TextButton(onPressed: (){
                   Navigator.of(context).pop();
                 }, child: const Text('No')),
                 TextButton(onPressed: (){
                   Navigator.of(context).pop();

                   FirebaseAuth.instance.signOut();

                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                     return LoginScreen();
                   }));
                 }, child: const Text('Yes')),
               ],
              );
            });





          }, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
