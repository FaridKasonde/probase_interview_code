


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import '../Models/RequestObject.dart';

class RequestGridTile extends StatefulWidget{
  final Request request;
  RequestGridTile({required this.request,super.key});

  @override
  _RequestGridTileState createState()=>_RequestGridTileState();

}
class _RequestGridTileState extends State<RequestGridTile>{
  late Request _request;
  @override
  void initState(){
    this._request=widget.request;
    setState((){});
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget> [
        AutoSizeText(
          "${_request.name},${_request.description}",
        ),
      ],
    );
  }
}