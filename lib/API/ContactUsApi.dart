import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';
class ContactUsApi{
  static Future<bool> contactUs(

      String name,
      String phone,
      String emailReceiver,
      String complants,
      String message ,
      String emailTo) async {
      print("Start Contact");
      final Email email = Email(
        body: '<h1 style="text-align:center;width:100%;"> وسيط عقاري</h1><br/><ul><li>رقم التليفون : $phone</li><li>الاسم : $name</li><li>الرساله : $message</li></ul>',
        recipients: ['$emailTo'],
        //bcc: ['$emailTo'],
        subject: '$complants',
        // recipients: ['osamaabdelaziz41@gmail.com'],
        // cc: ['$emailTo'],
        // bcc: [''],
        // attachmentPath: '/path/to/attachment.zip',
        isHTML: true,
      );

      await FlutterEmailSender.send(email);  
  }
}