


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_web/Models/RequestObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Views/GridWidget.dart';
import 'ViewRequestPage.dart';

class ExplorePage extends StatefulWidget{
  static final String routeName='/ExplorePageRoute';
  const ExplorePage({super.key});

  @override
  State<ExplorePage>createState()=>_ExplorePageState();

}
class _ExplorePageState extends State<ExplorePage>{
  TextEditingController _controller=TextEditingController();
  Stream _stream=FirebaseFirestore.instance.collection('requests').snapshots();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
        StreamBuilder(
        stream: _stream,
        builder: (context,snapshots){
          switch(snapshots.connectionState){
          case ConnectionState.waiting:
          return Center(child:CircularProgressIndicator());
          default:
          return GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshots.data?.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          ),
          itemBuilder:(context,index){
          DocumentSnapshot snapshot=snapshots.data?.docs[index]as DocumentSnapshot<Object>;
          Request currentRequest=Request(id:snapshot.id);
          currentRequest.getRequestInfoFromSnapshot(snapshot);
          return Material(
              child:InkResponse(
          enableFeedback: true,
          child: RequestGridTile(request:currentRequest,),
          onTap:(){
          Navigator.push(
          context,
          MaterialPageRoute(
          builder:(context)=>ViewRequestPage(request:currentRequest,),
          )
          );}));


          },);}},),],),);}
}