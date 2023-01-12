import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whats_app/shared/companents/constans.dart';

import '../../generated/l10n.dart';

Widget myDivider ()=>Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget cancelTextButton(context)=>TextButton(onPressed: (){
  Navigator.pop(context);
}, child: Text(S.of(context).cancel,style: TextStyle(color: green),));

Future <Widget>navigateTo(context,Widget)async=>await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget
  ),
);

Future <Widget>navigatePushAndDelete(context,Widget)async=>await Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
        builder: (context) => Widget
    ), (route) => false );

void showToast( {required String msg,required toastStatus state}){

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastMessageColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color? toastMessageColor(toastStatus state) {
  switch(state)
  {
    case(toastStatus.SUCESS):
      return Colors.green ;
      break ;
    case(toastStatus.ERROR):
      return Colors.red ;
      break ;
    case(toastStatus.WARNING):
      return Colors.amber;
      break;
  }
}
enum toastStatus {SUCESS , ERROR ,WARNING}
bool istrue(bool ? value) {
  if (value != null) {
    return value;
  }
  else
    return false;
}

PreferredSizeWidget buildAppBar({
  required String title ,
  required Color color,
  List <Widget> ?action  ,
  Widget ?leadingIcon,
})=>AppBar(
  systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: Brightness.light),
  backgroundColor: color,
  title: Text(
    title,
    style: TextStyle(color: Colors.white),
  ),
  actions: action,
);

Widget buildTextFormField(
{
  required var controller ,
  required Color color ,
  required Function validate ,
}) =>
    Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: color))
      ),
      child: TextFormField(
        validator: (value){
          validate (value) ;
        },
        controller: controller,
        decoration: InputDecoration(
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );