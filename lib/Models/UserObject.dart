

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_web/Models/RequestObject.dart';


class Contact{
  String id;
  String firstName;
  String lastName;

  Contact({this.id="",this.firstName="",this.lastName=""});


  String getFullName(){
    return this.firstName+ " "+this.lastName;
  }



  
}

class Userr extends Contact{
  late DocumentSnapshot snapshot;
  late String email;
  late String bio;
  late String password;
  late List<Request>myRequests;


  Userr({String id="",
  String firstName="",
    String lastName="",
  this.email="",
    this.bio=""}):
      super(
        id:id,
        firstName: firstName,
        lastName: lastName,

      ){

    this.myRequests=[];
  }



  Future<void>addUserToFirestore() async{
    Map<String,dynamic>data={
      "bio":this.bio,
      "email":this.email,
      "firstName":this.firstName,
      "lastName":this.lastName,
      "mRequestIDs":[],
    };
    await FirebaseFirestore.
    instance.doc('users/${this.id}').set(data);

  }



  Future<void>addRequestToMyRequests(Request request)async{
    this.myRequests.add(request);
    List<String>myRequestIDs=[];
    this.myRequests.forEach((request) {
      myRequestIDs.add(request.id);
    });
    await FirebaseFirestore.instance.doc('users/${this.id}').update({
      'myRequestIDs':myRequestIDs,
    });
  }




}