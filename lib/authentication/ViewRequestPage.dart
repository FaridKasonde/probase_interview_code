


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/RequestObject.dart';
import '../Views/TextWidget.dart';

class ViewRequestPage extends StatefulWidget{
  static final String routeName='/ViewRequestPage';
  final Request? request;
  const ViewRequestPage({this.request,super.key});
  @override
  State<ViewRequestPage>createState()=>_ViewRequestPageState();

}
class _ViewRequestPageState extends State<ViewRequestPage>{
  late Request _request;

  @override
  void initState(){
    this._request=widget.request!;
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:AppBarText(text:'View Request'),

      ),
          body: SingleChildScrollView(
        child:Column(
        children: [
          AutoSizeText(""
        "${_request.name},${_request.description}")
      ],
    )
    ),
    );
  }
}