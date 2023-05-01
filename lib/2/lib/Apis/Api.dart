import 'dart:convert';
import 'package:chatgpt/Apis/Api_Key.dart';
import 'package:http/http.dart' as http;

class Api {
 static final url = Uri.parse("https://api.openai.com/v1/images/generations");

 static generatedimage(String? textController,String size)async{
   var responce = await http.post(url,headers : {
     "Authorization":"Bearer ${ApiKey}","Content-Type": "application/json"
   },
       body: jsonEncode({"prompt": textController,
         "n": 1, "size" : "256x256",}) );
   if(responce.statusCode == 200){
     var data = jsonDecode(responce.body.toString());
     print("Data");
     return data["data"][0]["url"];
   }else{
     print("Failed to Fexh Data Image ");
   }
 }
}
