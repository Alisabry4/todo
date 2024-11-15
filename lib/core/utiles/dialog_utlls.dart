
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtlls {
  static void showLoading(context,{required String messsage,bool isDismissble =true}){
    showDialog(
      barrierDismissible: isDismissble,
      context: context, builder: (context)=>
    
    CupertinoAlertDialog(
      
      content:Row(
        children: [
          Text(messsage),
          Spacer(),
          CircularProgressIndicator()

        ],
      )
    ),);
    
  }
  static void hide(context){
    Navigator.pop(context);

  }
  static void showMessage(context,{String? title,String? body,String? posActionTitle,String?negActionTitle
  ,VoidCallback? posAction,
  VoidCallback? negAction,
  }){
    showDialog(context: context, builder: (context)=>
    CupertinoAlertDialog(
      title: title!=null?Text(title):null,
      content: body!=null?Text(body):null,
      actions: [
        if(posActionTitle!= null)
        MaterialButton(onPressed: (){
          Navigator.pop(context);
          posAction?.call();
        }, child:Text(posActionTitle)),
        if(negActionTitle!= null)
        MaterialButton(onPressed: (){
           Navigator.pop(context);
          negAction?.call();
        }, child: Text(negActionTitle))
      ],
    )
    );

  }}