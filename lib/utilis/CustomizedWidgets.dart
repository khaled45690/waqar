import 'package:easy_localization/easy_localization_delegate.dart';

import 'package:flutter/material.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/utilis/Utils.dart';



final String X2 = "@2x";
final String X3 = "@3x";
Widget IconImage(String name, VoidCallback onClick,
    {String size, Color color, double width}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      highlightColor: Colors.grey,
      child: Image.asset(
        size == null ? "images/$name.png" : "images/$name$size.png",
        color: color,
        width: width != null ? width : 24,
        height:  width != null ? width : 24,
      ),
      onTap: onClick,
    ),
  );
}

Widget CustomTextField(String inputHeader, String hint,
    {bool secure = false,
    FormFieldValidator<String> validator,
    GlobalKey key,
    TextEditingController controller,
    bool selection = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        inputHeader,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Exo2-Bold"),
      ),
      Container(
        padding: EdgeInsets.only(top: 12.0),
      ),
      TextFormField(
          enableInteractiveSelection: selection,
          key: key,
          controller: controller,
          validator: validator,
          obscureText: secure,
          decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 0.5)),
              hintText: hint,
              hintStyle: AqarFont.baseFontStyle())),
      Container(
        padding: EdgeInsets.only(top: 12.0),
      )
    ],
  );
}

Widget customTextFieldWithIcon(String inputHeader, String hint, String iconPath,
    {bool secure = false,
    FormFieldValidator<String> validator,
    GlobalKey key,
    bool selection = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 2),
      ),
      Text(
        inputHeader,
        style: TextStyle(color: soundPlayerBg,
            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Tajawal"),
      ),

//      Container(
//        padding: EdgeInsets.only(top: 2.0),
//      ),

              Container(
                margin: EdgeInsets.only(right: 26, left: 26, bottom: 0),
                height: 40,
                width: double.infinity,
          child: TextFormField(
              enableInteractiveSelection: selection,
              key: key,
              validator: validator,
              obscureText: secure,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
//              labelText: '+966',
//              labelStyle: TextStyle(color: CustomColors.soundPlayerBg,
//                  fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Tajawal",background: Paint()..color = CustomColors.dial),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0 ),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(width: 0.2,color: mainColor),
                  ),
                  hintText: hint,
                  hintStyle: TextStyle(color: mainColor,
                      fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Tajawal"))),
        ),
    ],
  );
}

Widget appButton(String name, VoidCallback onPress,
    {Color bgColor = null, Color textColor = null}) {
  return Container(
  margin: EdgeInsets.only(right: 50, left: 50, bottom: 0),
  height: 60,
      width: double.infinity,
      child: RaisedButton(
        color: bgColor != null ? bgColor : mainColor,
        child: Text(name,
            style: AqarFont.baseRegularFont()
        ),
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(40.0)),
      ));
}


Widget appButtonbsmall(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 0),
      height: 10,
      width: 30,
      child: Container(
          decoration: new  BoxDecoration(
            gradient: LinearGradient(
                colors: [bgColor, bgColor2],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 2.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 40,
              )
            ],
          ),
          child: FlatButton(
            child: Text(name,
                style: AqarFont.baseRegularFont()),
//            onPressed: (){
//              print('button clicked');
//            }
            onPressed: onPress,
          ))
  );
}

Widget appButtonbgimage(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 0),
      height: 50,
      width: double.infinity,
      child: Container(
            decoration: new  BoxDecoration(
            gradient: LinearGradient(
            colors: [bgColor, bgColor2],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 2.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 40,
                )
              ],
            ),
          child: FlatButton(
            child: Text(name,
                style: AqarFont.baseRegularFont()),
            onPressed: onPress,
          ))
  );
}


Widget appButtonbgimageV2(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 0),
      height: 70,
      width: double.infinity,
      child: Container(
            decoration: new  BoxDecoration(
            gradient: LinearGradient(
            colors: [bgColor, bgColor2],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 2.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 40,
                )
              ],
            ),
          child: FlatButton(
            child: Text(name,
                style: TextStyle( fontSize: 14 ,color: Colors.white )),
            onPressed: onPress,
          ))
  );
}

Widget appButtonbgimageWithSmallText(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 0),
      height: 50,
      width: double.infinity,
      child: Container(
            decoration: new  BoxDecoration(
            gradient: LinearGradient(
            colors: [bgColor, bgColor2],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 2.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 40,
                )
              ],
            ),
          child: FlatButton(
            child: Text(name,
                style: AqarFont.baseRegularMidduimFont()),
            onPressed: onPress,
          ))
  );
}

Widget shareAppButtonbgimage(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 0),
      height: 50,
      width: double.infinity,
      child: Container(
            decoration: new  BoxDecoration(
            gradient: LinearGradient(
            colors: [bgColor, bgColor2],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 2.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
          //  borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 40,
                )
              ],
            ),
          child: Row(
            
          children: <Widget>[
            Expanded(
                flex:2,
                child: FlatButton(
            child: Text(name,
                style: AqarFont.baseRegularFont_SmallFont()),//AqarFont.baseRegularFont()),
            onPressed: onPress,
          )),
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                    child: Image.asset(
                      "images/shareApp.png",
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            
          ],
        ),
        )
  );
}

Widget addCancelButton(String name, VoidCallback onPress,
    {Color bgColor = null, Color textColor = null}) {
  return Container(
      height: 40,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: mainColor),
            borderRadius:
            BorderRadius.all(Radius.circular(10.0))),
        color: bgColor != null ? bgColor : mainColor,
        child: Text(name,
            style: TextStyle(
                fontSize: 20,
                color: textColor != null ? textColor : Colors.white,
                fontFamily: "Tajawal")),
        onPressed: onPress,
      )
  );
}


Widget appButtonbgimage_normal(String name, VoidCallback onPress, {Color bgColor , Color bgColor2 }) {
  return Container(
      margin: EdgeInsets.only(right: 5, left: 5, bottom: 0),
      height: 50,
      width: double.infinity,
      child: Container(
          decoration: new  BoxDecoration(
            gradient: LinearGradient(
                colors: [bgColor, bgColor2],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 2.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 0,
              )
            ],
          ),
          child: FlatButton(
            child: Text(name,
                style: AqarFont.baseRegulartext()),
//            onPressed: (){
//              print('button clicked');
//            }
            onPressed: onPress,
          ))
  );
}

buildSearchAppbar(String title, BuildContext context) => AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(color: bgColor, fontFamily: "Tajawal"),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
//        Container(
//          margin: EdgeInsets.all(16),
//          child: IconImage('btn_search', () {
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => SearchScreen()));
//          }),
//        ),
      ],
    );

bool isDialogShowing = false;

void showAppLoading(BuildContext context, {String msg}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => new Dialog(
            backgroundColor: Colors.transparent,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                msg != null
                    ? Text(msg, style: AqarFont.baseFontStyle())
                    : Container(),
                RefreshProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ],
            ),
          ));
  isDialogShowing = true;
}

void hideAppDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
  isDialogShowing = false;
}

String L(String word, BuildContext context) {
  if (context != null) {
    return AppLocalizations.of(context).tr("noUser.$word");
  } else
    return word;
}

void showLoginFirstDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => new Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: Container(
                        margin: EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/hold_up.png',
                          fit: BoxFit.fill,
                        ))),
                Text(
                  L('title', context),
                  style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tajawal"),
                ),
                Text(
                  L('content', context),
                  style: TextStyle(
                      color: blackColor, fontFamily: "Tajawal"),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 20,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  color: mainColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
//                        builder: (context) => RegisterScreen()
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Center(
                        child: Text(L('register', context),
                            style: TextStyle(
                                color: bgColor,
                                fontSize: 16,
                                fontFamily: "Tajawal"))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(L('already', context),
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                              fontFamily: "Tajawal")),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
//                                builder: (context) =>
//                                    Login(title: L('login', context))
                            ));
                          },
                          child: Text(
                            L('login', context),
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Tajawal"),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )));
}

void showSnakBar(
  GlobalKey<ScaffoldState> scafold,
  String msg,
) {
  final snackBar = SnackBar(
    content: Text(
      msg,
      style: AqarFont.baseFontStyle(),
    ),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!
  scafold.currentState.showSnackBar(snackBar);
}

showInputDialog (
    BuildContext context, Function(String) onInputChanged, String title,
    {String okText,
    String cancelText,
    VoidCallback onCancel,
    GlobalKey<FormFieldState> textKey}) {
  // set up the buttons
  // set up the AlertDialog
  GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();
  var alert = Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Center(child: Text(title)),
          content: Form(
              key: formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField("", "", selection: false, key: textKey,
                        validator: (t) {
                      if (t.length < 3) return "more than 3 characters";
                    }),

                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Expanded(
                          flex: 1,
                          child: Container(
                              height: 40,
                              child: RaisedButton(
                                color: mainColor,
                                child: Text( okText,style: TextStyle(
                                    fontSize: 18,
                                    color: bgColor,
                                    fontFamily: "Tajawal")),
                                onPressed: () {
                                  onInputChanged(textKey.currentState.value);
                                  hideAppDialog(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(10.0)),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              child: Text(cancelText,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: mainColor,
                                      fontFamily: "Tajawal")),
                              onPressed: () {
                                hideAppDialog(context);
                                onCancel();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))));
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Utils.wrapWithtinLayoutDirection(alert);
    },
  );
}

showYesNoDialog(BuildContext ctx , String msg ,String yesText , String noText, {VoidCallback onYes , VoidCallback onNo } ) { 
final alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
           msg,
          textAlign: TextAlign.center,
          style: AqarFont.getBoldFont(),
        ),
        Container(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  height: 40,
                  child: RaisedButton(
                    color: mainColor,
                    child: Text(yesText,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontFamily: "Tajawal")),
                    onPressed: onYes,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: mainColor),
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                  child: Text(noText,
                      style: TextStyle(
                          fontSize: 20,
                          color: mainColor,
                          fontFamily: "Tajawal")),
                  onPressed: onNo,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Utils.wrapWithtinLayoutDirection(alert);
    },
  );
}