
import 'package:final_web/authentication/CreateRequestPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_web/Models/AppConstants.dart';
import 'package:final_web/Views/TextWidget.dart';
import 'dart:io';


//import 'package:file_picker/file_picker.dart';

class SignUpPage extends StatefulWidget {
  static final String routeName='/SignUpPageRoute';

  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey=GlobalKey<FormState>();
  final FirebaseAuth auth=FirebaseAuth.instance;
  TextEditingController _firstNameController=TextEditingController();
  TextEditingController _lastNameController=TextEditingController();
  TextEditingController _cityNameController=TextEditingController();
  TextEditingController _countryController=TextEditingController();
  TextEditingController _bioController=TextEditingController();

  void _signUp(){
    if(!_formKey.currentState!.validate()){return;}
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: AppConstants.currentUser.email,
        password:AppConstants.currentUser.password
    ).then((firebaseUser){
      final User? firebaseUser=auth.currentUser;
      String? userID=firebaseUser?.uid;
      AppConstants.currentUser.id=userID!;
      AppConstants.currentUser.firstName=_firstNameController.text;
      AppConstants.currentUser.lastName=_lastNameController.text;
      AppConstants.currentUser.bio=_bioController.text;
      AppConstants.currentUser.addUserToFirestore().whenComplete((){
          FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AppConstants.currentUser.email,
          password: AppConstants.currentUser.password,
        ).whenComplete(() {
            Navigator.push(context,
                MaterialPageRoute(builder:(e)=>const CreatingRequestPage()));

        });

      });
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:AppBarText(text: 'Sing Up Page'),
      ),

      body: Center(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 80.0,50.0,50.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child:Column(
                    children:<Widget> [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'First name'
                          ),
                          controller: _firstNameController,
                          validator: (text){
                            if(text!.isEmpty){
                              return "Please enter a first name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Last name'
                          ),
                          controller: _lastNameController,
                          validator: (text){
                            if(text!.isEmpty){
                              return "Please enter a last name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'City'
                          ),
                          controller: _cityNameController,
                          validator: (text){
                            if(text!.isEmpty){
                              return "Please enter a valid city";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Country'
                          ),
                          controller: _countryController,
                          validator: (text){
                            if(text!.isEmpty){
                              return "Please enter a valid country";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Bio'
                          ),
                          style: TextStyle(

                          ),
                          maxLines: 3,
                          controller: _bioController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),



                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: MaterialButton(onPressed: (){
                    _signUp();
                  },
                    child: Text('Submit',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),
    ),
                    color: Colors.grey,
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
  ],
            ),
      ),

    )));
  }
}
