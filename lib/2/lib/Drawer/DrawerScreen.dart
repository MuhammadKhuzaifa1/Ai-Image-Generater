
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PrivacyPolicyScreen.dart';
import 'TermsAndConditions.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Center(child:ListTile(title: Text("Chatgpt"),subtitle: Text("Openai.com"),leading: Icon(Icons.account_circle,size: 50,),) ,),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Ploicy'),
            onTap: () {
              Get.back();
              Get.to(()=>PrivacyPolicyScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.private_connectivity),
            title: const Text('Terms And Conditions'),
            onTap: () {
              Get.back();
              Get.to(()=>TermsAndConditions());
            },
          ),
          ListTile(
            title: const Text('Version 2.1.0'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
