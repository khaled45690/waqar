import 'package:flutter/material.dart';
import 'package:waqarapp/constants/customcolors.dart';
class AqarFont {
  static var page_title= "Home";


  static baseRegularcolorFont({double fontSize = 18}) => TextStyle(color: desgin_button1_start,fontWeight: FontWeight.bold,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static baseRegulartext({double fontSize = 16}) => TextStyle(color: bgColor,fontWeight: FontWeight.bold, //fontFamily: "Tajawal",
   fontSize: fontSize,);
  static baseFontStyle({double fontSize = 14}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: bgColor ,fontWeight: FontWeight.w500);
  static getBoldFont({double fontSize = 12}) => TextStyle(color: button1 ,fontWeight: FontWeight.bold,//fontFamily: "Tajawal", 
  fontSize: fontSize);
  static getinputFont({double fontSize = 13}) => TextStyle(color: desgin_button1_start,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.w500);
  static getinputFontV2({double fontSize = 11}) => TextStyle(color: desgin_button1_start,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.w500);
  static getRegularFont({double fontSize = 18}) => TextStyle(color: bgColor,fontWeight: FontWeight.bold,//fontFamily: "Tajawal", 
  fontSize: fontSize);
  static getLightFont_TextFormField2({double fontSize = 20}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontWeight: FontWeight.w500);






  static getLightFont({double fontSize = 14}) => TextStyle(fontFamily: "Exo2-ExtraLight", fontSize: fontSize,color: blackColor);
  static getLightFont_TextFormField({double fontSize = 14}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static getLightFont_TextFormField3({double fontSize = 20}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static gettitleFont({double fontSize = 30}) => TextStyle(color: blackColor ,fontFamily: "Exo2-ExtraBold", fontSize: fontSize);
  static gettitleFontinside({double fontSize = 20}) => TextStyle(color: blackColor ,fontFamily: "Exo2-ExtraBold", fontSize: fontSize,backgroundColor: button2);
  static getBoldFontinside({double fontSize = 20}) => TextStyle(color: blackColor ,fontFamily: "Exo2-ExtraBold", fontSize: fontSize);
  static getSemiBoldFont({double fontSize = 23}) => TextStyle(color: blackColor,fontFamily: "Exo2-ExtraBold", fontSize: fontSize);
  static getSemiBold({double fontSize = 23}) => TextStyle(fontFamily: "Droid.Arabic", fontSize: fontSize);
  static getMediumFont({double fontSize = 20}) => TextStyle(color: desgin_button1_start,fontFamily: "Exo2-ExtraLight", fontSize: fontSize);
  static getRegularFontinside({double fontSize = 16}) => TextStyle(color: blackColor,fontFamily: "Droid.Arabic", fontSize: fontSize);
  static baseRegularFont({double fontSize = 16}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize ,color: bgColor );
    static baseRegularFont_SmallFont({double fontSize = 13}) => TextStyle(//fontFamily: "Tajawal", 
    fontSize: fontSize ,color: bgColor,fontWeight: FontWeight.w500);

  static baseRegularFontV2({double fontSize = 16}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize ,color:  button3);
  static baseRegularMidduimFont({double fontSize = 13}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize ,color: bgColor );
  static getsmallFont({double fontSize = 10}) => TextStyle(color: button1,//fontFamily: "Tajawal", 
  fontSize: fontSize);
  static getLightFont_TextFormFieldtext({double fontSize = 20}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static getLightFont_TextFormFieldtextheader({double fontSize = 25}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static getLightFont_TextFormsmall({double fontSize = 10}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static getLightFont_Textheadertablet({double fontSize = 19}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button1_start,fontStyle: FontStyle.normal);
  static baseFontStyleWithBackground({double fontSize = 17}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: blackColor ,fontWeight: FontWeight.w500,backgroundColor: grey_ligth);

  static getLighttable({double fontSize = 15}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: desgin_button4_start,fontStyle: FontStyle.normal);
 static getLighttableRed({double fontSize = 13}) => TextStyle(//fontFamily: "Tajawal", 
 fontSize: fontSize,color: desgin_button_red,fontStyle: FontStyle.normal);
 static getLighttableBlue({double fontSize = 13}) => TextStyle(//fontFamily: "Tajawal", 
 fontSize: fontSize,color: desgin_button4_end,fontStyle: FontStyle.normal);
 static getLighttableBlueV2({double fontSize = 13}) => TextStyle(//fontFamily: "Tajawal", 
 fontSize: fontSize,color: desgin_button4_end,fontStyle: FontStyle.normal);


}

class MansaFont {
  static var page_title= "Home";
  static getBoldFont({double fontSize = 40}) => TextStyle(color: bgColor ,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.w500);
  static getsmallFont({double fontSize = 12}) => TextStyle(color: bgColor,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.normal);
  static getLightFont_TextFormField({double fontSize = 14}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: lightBgColor,fontStyle: FontStyle.normal);
  static gettitleFont({double fontSize = 25}) => TextStyle(color: blackColor ,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.bold);
  static gettitleFontinside({double fontSize = 15}) => TextStyle(color: bgColor ,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.bold);
  static gettitleFontinside_blue({double fontSize = 18}) => TextStyle(color: lightBgColor ,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.bold);
  static gettitleFontinside_blueV2({double fontSize = 16}) => TextStyle(color: lightBgColor , fontSize: fontSize,fontWeight: FontWeight.bold);
  static getLightFont({double fontSize = 12}) => TextStyle(//fontFamily: "Tajawal", 
  fontSize: fontSize,color: blackColor,fontWeight: FontWeight.bold);
  static getLightFontV2({double fontSize = 12}) => TextStyle( fontSize: fontSize,color: blackColor,fontWeight: FontWeight.bold);
  
  static gettitleFont_payment_1({double fontSize = 35}) => TextStyle(color: Colors.black ,//fontFamily: "Tajawal", 
  fontSize: fontSize,fontWeight: FontWeight.bold);
  static gettitleFont_payment_2({double fontSize = 25}) => TextStyle(color: Colors.black ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.normal);
  static getBoldFontinside({double fontSize = 20}) => TextStyle(color: blackColor ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.w500);
  static getBoldFontinside_V2({double fontSize = 10}) => TextStyle(color: blackColor ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.w500);
  static getBoldFontinside_orange({double fontSize = 20}) => TextStyle(color: button3 ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.w500);
  static getBoldFontinside_orange2({double fontSize = 17}) => TextStyle(color: button3 ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.w500);
  static baseFontStyle({double fontSize = 20}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: bgColor ,fontWeight: FontWeight.w500);
  static baseFontStyleWithBackground({double fontSize = 17}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: blackColor ,fontWeight: FontWeight.w500,backgroundColor: grey_ligth);
  static baseFontStyle2({double fontSize = 25}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: bgColor ,fontWeight: FontWeight.w500);
  static getmenufont({double fontSize = 12}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: bgColor,fontWeight: FontWeight.bold);
  static getMediumFont_gray({double fontSize = 20}) => TextStyle(color: grey_ligth2,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.normal);

static getMediumFont_gray2({double fontSize = 15}) => TextStyle(color: grey_ligth2,//fontFamily: "Tajawal",
 fontSize: fontSize,fontWeight: FontWeight.normal);



  static getBoldnext({double fontSize = 25}) => TextStyle(color: bgColor ,//fontFamily: "Tajawal",
   fontSize: fontSize,fontWeight: FontWeight.w500);
  static baseRegularFont({double fontSize = 20}) => TextStyle(///fontFamily: "Tajawal",
   fontSize: fontSize ,color: bgColor,fontWeight: FontWeight.w500);
  static baseRegulartext({double fontSize = 16}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize ,color: bgColor,fontWeight: FontWeight.w500);


  static getSemiBoldFont({double fontSize = 23}) => TextStyle(color: blackColor,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getSemiBold({double fontSize = 23}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getMediumFont({double fontSize = 20}) => TextStyle(color: mainColor,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getRegularFont({double fontSize = 18}) => TextStyle(color: mainColor,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getRegularFontinside({double fontSize = 16}) => TextStyle(color: blackColor,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getRegularFontinside2({double fontSize = 14}) => TextStyle(color: blackColor,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static baseRegularcolorFont({double fontSize = 18}) => TextStyle(//fontFamily: "Tajawal",
   fontSize: fontSize,color: gray);
   static baseRegularcolorFontE({double fontSize = 18}) => TextStyle(//fontFamily: "Tajawal",
    fontSize: fontSize,color: Colors.black);
  static getinputFont({double fontSize = 15}) => TextStyle(color: blackColor,//fontFamily: "Tajawal",
   fontSize: fontSize);


  static getMediumFont_small({double fontSize = 20}) => TextStyle(color: gray,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getMediumFont_medium({double fontSize = 20}) => TextStyle(color: grey_ligth,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getMediumFont_medium2({double fontSize = 20}) => TextStyle(color: Colors.black,//fontFamily: "Tajawal",
   fontSize: fontSize);
  static getMediumFont_medium_blue({double fontSize = 16}) => TextStyle(color: desgin_button4_end,//fontFamily: "Tajawal",
   fontSize: fontSize);


}
