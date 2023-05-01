import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Custom_Buttom({VoidCallback? Gonpress, String? Gtxt,VoidCallback?  Donpress,String? Dtxt}){
  return Row(
    children: [
      Expanded(child:NeumorphicButton(onPressed: Gonpress,padding: EdgeInsets.zero,
        child:Container(child: Center(child: Text(Gtxt!,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
          height:  50,decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)),) ,), ),
      SizedBox(width: 5,),

      Expanded(child:NeumorphicButton(onPressed: Donpress,padding: EdgeInsets.zero,
        child:Container(child: Center(child: Text(Dtxt!,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
          height:  50,decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)),) ,), ),
    ],
  );
}



