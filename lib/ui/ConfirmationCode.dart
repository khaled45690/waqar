import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waqarapp/API/AuthApi.dart';
import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/constants/strings.dart';
import 'package:waqarapp/model/UserVM.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:waqarapp/ui/HomeScreen.dart';
import 'package:waqarapp/utilis/CustomizedWidgets.dart';


class ConfirmationCode extends StatefulWidget{
  UserVM user;
  ConfirmationCode(this.user);
  @override
  _ConfirmationCodeState createState()=>_ConfirmationCodeState();
}




class _ConfirmationCodeState extends State<ConfirmationCode> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var first = GlobalKey<FormFieldState>();
  var second = GlobalKey<FormFieldState>();
  var third = GlobalKey<FormFieldState>();
  var fourth = GlobalKey<FormFieldState>();
  int _currentIdex=0;
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  @override void initState() {
    print("Emaillllllll For Registration");
    print(widget.user.Email);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: gray,


        appBar: AppBar(
        flexibleSpace: Container(
        decoration: new BoxDecoration(
        gradient: new LinearGradient(
        colors: [gray, gray],
        begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(0.5, 0.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp),
    image: DecorationImage(
    image: AssetImage("images/actionbar.png"),
    fit: BoxFit.fill,
    ),
    ),
    ),
    title: new Text(
    "تأكيد الحساب ",
    style: AqarFont.baseFontStyle(),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    elevation: 0.0,
    leading: new IconButton(
    icon: new Image.asset("images/actionback.png"),
    iconSize: 30.0,
    padding: EdgeInsets.fromLTRB(20, 17, 0, 17),
    onPressed: () => Navigator.of(context).pop()),
    // actions: <Widget>[
    //   IconButton(
    //     icon: new IconButton(icon: new Image.asset("images/asset17.png")),
    //     iconSize: 40.0,
    //     padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
    //     onPressed: () => _scaffoldKey.currentState.openEndDrawer(),

    //   ),
    // ],
    ),

      body:Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
         
            new Image.asset(
              'images/asset12.png',
              height: 250.0,
              width: 250.0,
            ),
            new Text("من فضلك قم بادخال الكود"),
            new SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(""),
                ),
                
                
                
               Expanded(
                  flex: 1,
                  child: TextFormField(
                      key: fourth,
                      //initialValue: "4",
                      focusNode: focus3,
                      keyboardType: TextInputType.number,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: MansaFont.getLightFont(),
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 10.0),
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 0.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 1.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                    ),
                    
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                      key: third,
                      //initialValue: "3",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    focusNode: focus2,
                    textAlign: TextAlign.left,
                    style: MansaFont.getLightFont(),
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 10.0),
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 0.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 1.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),

                    ),
                    onFieldSubmitted: (v){
                      FocusScope.of(context).requestFocus(focus3);
                    },
                     //autofocus: true,
                    onChanged: (String value){
                      if(value.length>=1){
                         FocusScope.of(context).requestFocus(focus3);
                        //  _next(index,);
                          return;
                      }else if (value.isEmpty) {
                          // _prev(index);
                        }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                      key: second,
                     //initialValue: "2",
                      focusNode: focus1,
                      keyboardType: TextInputType.number,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: MansaFont.getLightFont(),
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 10.0),
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 0.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 1.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                    ),
                    onFieldSubmitted: (v){
                      FocusScope.of(context).requestFocus(focus2);
                    },
                     //autofocus: true,
                    onChanged: (String value){
                      if(value.length>=1){
                         FocusScope.of(context).requestFocus(focus2);
                        //  _next(index,);
                          return;
                      }else if (value.isEmpty) {
                          // _prev(index);
                        }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                      key: first,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                   // maxLength: 2,
                   //initialValue: "1",
                    textAlign: TextAlign.left,
                    style: MansaFont.getLightFont(),
                    
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 10.0),
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 0.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(color: grey_ligth, width: 1.0),
                          //   borderRadius: BorderRadius.circular(8.0),
                          // ),
                    ),
                    onFieldSubmitted: (v){
                      FocusScope.of(context).requestFocus(focus1);
                    },
                     autofocus: true,
                    onChanged: (String value){
                      if(value.length>=1){
                         FocusScope.of(context).requestFocus(focus1);
                        //  _next(index,);
                          return;
                      }else if (value.isEmpty) {
                          // _prev(index);
                        }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(""),
                ),
               
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Text("السوق سوقك هو واحد من أهم روّاد المواقع الإلكترونية المتخصصة في مجال الإعلانات المبوبة والتي تمكّن المستخدمين سواء كانوا بائعين أم مشترين من بيع وشراء مختلف السلع والمنتجات والخدمات خلال أقصر وقت ممكن وبأقل جهد يُذكر، وسواء كانت حالة تلك المنتجات جديدة أم مستعملة. وحتى يسهل على المستخدم إيجاد ما يبحث عنه أو الإعلان عمّا يريد بيعه يوجد أقسام رئيسية وفرعية لعرض وتصفّح مختلف أنواع السلع والخدمات المتداولة بينهم وإتاحة التواصل المباشر فيما بينهم بكل سهولة." , 
            // style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20.0,
            //         fontStyle: FontStyle.italic,
            //         // padding: EdgeInsets.all(24.0),
            //         color: Colors.black)),
            // ),
             new SizedBox(height: 10.0),
              appButtonbgimage("التالي",
                        () => verifyCode(),
                         //() => getRegister(),
                            bgColor: lightBgColor, bgColor2: transColor),
          ],
        ),
        
      ),
      ),
       
    );
  }




// void _next(int index) {
//   if(index ==1){
//     setState(() {
//       _currentIdex = index + 1;
//     });
//   }
//     if (index != widget.length) {
//       setState(() {
//         _currentIdex = index + 1;
//       });
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
//       });
//     }
//   }

//   void _prev(int index) {
//     if (index > 0) {
//       setState(() {
//         if (_listControllerText[index].text.isEmpty) {
//           _listControllerText[index - 1].text = ' ';
//         }
//         _currentIdex = index - 1;
//       });
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
//       });
//     }
//   }




  verifyCode() {
    try {
        print(first.currentState.value);
        print(second.currentState.value);
        if(first.currentState.value==null || first.currentState.value==""||
        second.currentState.value==null || second.currentState.value==""||
        third.currentState.value==null || third.currentState.value==""||
        fourth.currentState.value==null || fourth.currentState.value==""){
          showInSnackBar("من فضلك قم بادخال البيانات", context, _scaffoldKey);
        }else{
             showAppLoading(context);
          AuthApi.verifyCode(widget.user.Id , widget.user.Email , first.currentState.value,
          second.currentState.value,third.currentState.value ,  fourth.currentState.value).then((response) {
        if (response.code ==200 ) {
           //  hideAppDialog(context);
            print("Response Code is 200");
            saveUser(response.data).then((done) {
              print("Start Saving User");
              if (done){
                print(response.data);
                hideAppDialog(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
                  

            }, onError: (error) {
              print("saving user Error : :  :$error");
              hideAppDialog(context);
            });
          } else {
            showInSnackBar("${response.message}", context, _scaffoldKey);
            print("${response.message}");
            hideAppDialog(context);
            //showInSnackBar("${response.message}", context, _scaffoldKey);
          }
        setState(() {
         //this.loginApi = false;
        });
      }, onError: (error) {
        print("login Error : : :$error");
        setState(() {
         // this.loginApi = false;
        });
      });
        }
     
    } catch (error) {
      hideAppDialog(context);
   //   showSnack(error.toString());
    }
  }


}

mixin MansaFont {
  static getLightFont() {}
}

