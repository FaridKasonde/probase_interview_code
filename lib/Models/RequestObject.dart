


import 'package:cloud_firestore/cloud_firestore.dart';

import 'AppConstants.dart';


class Request{

  late String id;
  late String name;
  late String description;

  Request({this.id="",this.description=" ",this.name=""});


  Future<void>getRequestInfoFromFirestore() async{
    DocumentSnapshot snapshot=
    await FirebaseFirestore.
    instance.collection('requests').
    doc(this.id).get();
    this.getRequestInfoFromSnapshot(snapshot);

  }
  void getRequestInfoFromSnapshot(DocumentSnapshot snapshot){
    this.name=snapshot['name']??"";
    this.description=snapshot['description']??"";
    String hostID=snapshot['hostID']??"";
  }

  Future<void>deleteRequestInfoFromFirestore()async{
    final FirebaseFirestore db=FirebaseFirestore.instance;
    final CollectionReference request=db.collection('request');
    await request.doc('newRequest').delete();
  }
  Future<void>addRequestInfoToFirestore()async{
    Map<String,dynamic>data={
      "name":this.name,
      "description":this.description,
      "hostID":AppConstants.currentUser.id,
    };
    DocumentReference reference=await FirebaseFirestore.
    instance.collection('requests').add(data);
    this.id=reference.id;
    await AppConstants.
    currentUser.addRequestToMyRequests(this);

  }


  //Start of updating

  Future<void>updateRequestInfoInFirestore() async{
    Map<String,dynamic>data={
      "name":this.name,
      "description":this.description,
      "hostID":AppConstants.currentUser.id,

    };
    await FirebaseFirestore.instance.doc('requests/${this.id}').update(data);


  }

//End of updating receipt








}