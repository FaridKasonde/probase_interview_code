import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Models/AppConstants.dart';
import '../Models/UserObject.dart';
import 'CreateRequestPage.dart';
import 'ExplorePage.dart';
import 'SignUpPage.dart';


class LoginScreen extends StatefulWidget {
  static final String routeName='/LoginScreenRoute';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey=GlobalKey<FormState>();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  String adminEmail=" ";
  String adminPassword=" ";



  void _signUp(){
    if(_formKey.currentState!.validate()){
      String email=_emailController.text;
      String password=_passwordController.text;
      AppConstants.currentUser=Userr();
      AppConstants.currentUser.email=email;
      AppConstants.currentUser.password=password;
      Navigator.pushNamed(context,SignUpPage.routeName);
    }

  }

  void _allowAdminToLogin() async{

    if(_formKey.currentState!.validate()) {
      adminEmail = _emailController.text;
      adminPassword = _passwordController.text;


      SnackBar snackBar = SnackBar(
        content: Text(
          "Checking Credentials",
          style: TextStyle(
            fontSize: 36,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      User? currentAdmin;
      await FirebaseAuth.instance.
      signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      ).then((fAuth) {
        currentAdmin = fAuth.user;
      }).catchError((onError) {
        //display error message
        final snackBar = SnackBar(
          content: Text(
            "Error Occured" + onError.toString(),
            style: const TextStyle(
              fontSize: 36,
              color: Colors.red,
            ),
          ),
          backgroundColor: Colors.pinkAccent,
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      if (currentAdmin != null) {
        await FirebaseFirestore.instance.
        collection("admins").
        doc(currentAdmin!.uid)
            .get().then((snap) {
          if (snap.exists) {
            Navigator.push(context,
                MaterialPageRoute(builder: (e) => const CreatingRequestPage()));
          }
          else {
            SnackBar snackBar = SnackBar(
              content: Text(
                "No Admin Found",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.red,
                ),
              ),
              backgroundColor: Colors.pinkAccent,
              duration: Duration(seconds: 5),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 80.0,50.0,50.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Welcome to ${AppConstants.appName}!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child:Column(
                    children:<Widget> [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email'
                          ),
                          validator: (text){
                            if(!text!.contains('@')){
                              return 'Please enter a valid email adress';
                            }
                            return null;

                          },
                          controller: _emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password'
                          ),
                          obscureText:true ,
                          validator: (text){
                            if(text!.length<6){
                              return 'Please enter a valid password';
                            }
                            return null;

                          },
                          controller: _passwordController,

                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: MaterialButton(onPressed: (){
                    _allowAdminToLogin();
                  },
                    child: Text('Login',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),),
                    color: Colors.grey,
                    height: MediaQuery.of(context).size.height/15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: MaterialButton(onPressed: (){
                    _signUp();
                  },
                    child: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color:Colors.grey,
                    height: MediaQuery.of(context).size.height/15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
