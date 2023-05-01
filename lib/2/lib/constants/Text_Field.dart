

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

TextFormFiald({int? value,TextEditingController? Controllers, String? hinttxt,FormFieldSetter?onFieldSubmitteds ,Icon? icons}){
  return NeumorphicButton(onPressed: () {

  },
    padding: EdgeInsets.zero,
    child: Container(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          maxLength: value,
          controller: Controllers,onFieldSubmitted:onFieldSubmitteds ,
             decoration: InputDecoration(
           suffixIcon: icons,
          hintText: hinttxt,
          border: InputBorder.none,
        ),),
      ),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5), ),
    ),
  );
}
