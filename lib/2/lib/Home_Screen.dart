import 'package:chatgpt/Drawer/DrawerScreen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:chatgpt/Apis/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'Apis/provider.dart';
import 'MobileAds.dart';
import 'constants/Text_Field.dart';
import 'constants/Utils.dart';


class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final Email = TextEditingController();
  final Password = TextEditingController();

  Map<String, String>? mudata;
@override
  void initState() {
 MobileAdsContrell().loadInterstitialAd();
  Future.delayed(Duration(seconds: 3)).then((value) =>   MobileAdsContrell().AppopenAd(),);
  FlutterNativeSplash.remove();
  getadata();
    super.initState();
  }
  var size = ["Small","Medium","Large"];
  var values = ["256x256","512x512","1024x1024"];
  String? dropValue;TextEditingController inputText = TextEditingController();
  String  images ="";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<DownloadingImageController>(context, listen: false);
    var proSatus = Provider.of<DownloadingImageController>(context);
    DownloadingImageController AuthController = Provider.of(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.grey.shade100.withOpacity(0.3),
        child: mudata != null ? mudata!["status"] == "enable" ? AdWidget(
          ad: MobileAdsContrell().getBannnerAd(mudata!["adId"].toString())..load(),
        ): Container(child: Center(child: Text("Ad not available"),),) : Container(child: Center(child: Text("Ad Loading..."),),),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(centerTitle: true,
        leading: InkWell(onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
            child: Icon(Icons.menu,color: Colors.black,)),
        title: Text("Ai Image Generator",
            style: GoogleFonts.aldrich(color: Colors.black)),
        backgroundColor: Colors.white70,
        elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(children: [
                Expanded(child: TextFormFiald(Controllers: inputText,value:1 , hinttxt:
                "Search...", onFieldSubmitteds: (newValue) async {
                  if (dropValue!.isNotEmpty && inputText.text.isNotEmpty) {
                    setState(() {
                      loading = false;
                    });
                    Utils.flushBarMessage("please wait..", context);
                    images = await Api.generatedimage(
                        inputText.text, dropValue!);
                    setState(() {
                      loading = true;
                    });
                  } else {
                    Utils.flushBarMessage("Please select image size", context);
                  }
                },)),
                SizedBox(width: 3,),
                NeumorphicButton(padding: EdgeInsets.zero,
                  onPressed: () async {
                    if (dropValue!.isNotEmpty && inputText.text.isNotEmpty) {

                      MobileAdsContrell().showInterstitialAd();
                      setState(() {
                        loading = false;
                      });
                      Utils.flushBarMessage("please wait..", context);
                      images =
                      await Api.generatedimage(inputText.text, dropValue!);
                      setState(() {
                        loading = true;
                      });
                    } else {
                      Utils.flushBarMessage(
                          "Please select image size", context);
                    }
                  },
                  child: Container(height: 50,
                    width: 60,
                    child: Center(
                      child: Icon(Icons.send, color: Colors.black, size: 30,),),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),

                    ),),
                )

              ],),

              SizedBox(height: 15,),
              Row(children: [
                SizedBox(width: 3,), NeumorphicButton(padding: EdgeInsets.zero,
                    onPressed: () {

                    },
                    child: Container(
                      height: 50, width: 90, child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: DropdownButton(
                          value: dropValue,
                          hint: Text("Size",
                              style: GoogleFonts.aldrich(color: Colors.black)),
                          items: List.generate(size.length, (index) =>
                              DropdownMenuItem(child: Text(size[index],
                                  selectionColor: Colors.lightBlueAccent),
                                value: values[index],)),
                          onChanged: (value) {
                            setState(() {
                              dropValue = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)),)),
                SizedBox(width: 3,),
                Expanded(
                  child: NeumorphicButton(
                      padding: EdgeInsets.zero, onPressed: () {},
                      child: proSatus.loading ?
                      Container(height: 50, width: 90, child:
                      Center(child: Text(
                          "Downloading...  ${proSatus.progressData}.0%", style
                          : GoogleFonts.aldrich(color: Colors.white)),),
                          decoration: BoxDecoration(borderRadius: BorderRadius
                              .circular(5), color: Colors.lightBlueAccent)) :


                      NeumorphicButton(onPressed: () {
                        if (images.isNotEmpty) {

                          MobileAdsContrell().showInterstitialAd();
                          pro.saveimage(images, context);
                        } else {
                          Utils.flushBarMessage(
                              "Please generated image ", context);
                        }
                      }, padding: EdgeInsets.zero,
                        child: Container(height: 50, width: 90, child: Center(
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(child: Text("Download",
                                    style: GoogleFonts.aldrich(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16))),
                                SizedBox(width: 50,),
                                CircleAvatar(
                                    backgroundColor: Colors.green, radius: 17,
                                    child: Icon(
                                      Icons.download, color: Colors.white,
                                      size: 20,))
                              ],
                            ),
                          ),),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),),),
                      )),

                ),
              ],),
              SizedBox(height: 90,),
              loading ?
              Container(
                margin:   EdgeInsets.symmetric(horizontal: 15),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.black38,width: 1),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.3))
                  ],
                  image: DecorationImage(image:NetworkImage(images),fit: BoxFit.cover)
                ),
                // child: Card(
                //   child: Image.network(images,fit: BoxFit.cover,)),
              )
                  :
              Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(color: Colors.black87.withOpacity(0.7),height: 130,
                      "assets/loa.gif", fit: BoxFit.cover,),
                    SizedBox(height: 8,),
                    Text("Please Generated Image", style: GoogleFonts.aldrich(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
                  ],
                ),
              ),

              SizedBox(height: 40,),
            ],),
        ),

      ),

    );
  }     getadata() async {
    QuerySnapshot addata = await FirebaseFirestore.instance.collection("BannerAd").get();
    var data = addata.docs;
    print(data[0]["Status"].toString());
    print(data[0]["BannerAdId"].toString());
    setState(() {
      mudata = {
        "adId" : data[0]["BannerAdId"].toString(),
        "status" : data[0]["Status"].toString(),
      };
    });
  }
}