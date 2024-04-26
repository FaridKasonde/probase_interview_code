
import 'package:final_web/Models/RequestObject.dart';
import 'package:final_web/Views/TextWidget.dart';
import 'package:final_web/authentication/ExplorePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatingRequestPage extends StatefulWidget{
  static final String routeName='/CreateRequestPageRoute';
  final Request? request;
  const CreatingRequestPage({this.request,super.key});

  @override
  State<CreatingRequestPage>createState()=>_CreatingRequestPageState();

}

class _CreatingRequestPageState extends State<CreatingRequestPage>{

  final _formkey=GlobalKey<FormState>();

  TextEditingController _nameController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();

  void _saveRequest(){
    if(!_formkey.currentState!.validate()){return;}
    Request request=Request();
    request.name=_nameController.text;
    request.description=_descriptionController.text;
    request.addRequestInfoToFirestore().whenComplete(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ExplorePage()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: AppBarText(text:'Create a Request Screen'),
        actions:<Widget>[
          IconButton(
            onPressed:(){},
            icon:Icon(Icons.clear),),
          IconButton(
              onPressed:_saveRequest,
              icon:Icon(Icons.save,)
          ),
        ],
      ),

      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.fromLTRB(50.0,80.0,50.0,50.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child:TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Request name'
                          ),
                          controller: _nameController,
                          validator: (text){
                            if(text!.isEmpty){
                              return "Please enter a name.";
                            }else{
                              return null;
                            }
                          },
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child:TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Request description'
                          ),
                          controller: _descriptionController,
                          maxLines:3,
                          minLines: 1,
                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),),
    );
  }
}