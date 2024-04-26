
import 'package:final_web/authentication/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_web/authentication/login_screen.dart';
import 'authentication/CreateRequestPage.dart';
import 'authentication/ExplorePage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(
        apiKey: "AIzaSyDrma4xosPzEQj7w_105eka8fyAXtKqXvk",
        appId: "1:685539854359:web:c96f8312e644213ae33452",
        messagingSenderId: "685539854359",
      projectId: "finalweb-832db")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Probase POM',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       // useMaterial3: true,
      ),
      debugShowCheckedModeBanner:false,
      home:const LoginScreen(),
      routes:{
        LoginScreen.routeName:(context)=>LoginScreen(),
        SignUpPage.routeName:(context)=>SignUpPage(),
        CreatingRequestPage.routeName:(context)=>CreatingRequestPage(),
        ExplorePage.routeName:(context)=>ExplorePage(),

      }
    );
  }
}
