import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hexatour/src/views/screens/auth/change_password.dart';

class DynamicLinkService {
  static Future<void> initDynamicLink(BuildContext context) async {
   
   

    await FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    
      // debugPrint(dynamicLinkData.link as String?);
      final Uri? deepLink = dynamicLinkData.link;

      if (deepLink != null) {
      
        if (deepLink.queryParameters.containsKey('user_id')) {
          String? id = deepLink.queryParameters['user_id'];
       
          Get.to(ChangePassword(userID: id!));
        
        }
      }
    });
  }
}
