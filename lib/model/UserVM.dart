
import 'package:shared_preferences/shared_preferences.dart';

class UserVM {
    String Id;
   // String code;
   String Long_Lat ;
 double Long ;
 double Lat ;
    String UserName;
    String tempUserName;
    String Email;
    String UserImage;
    String Phone;
    String UserType;
    String Commercial_Register;
    String City;
    String Address;
    String PasswordHash;
    String ManagerName;
    String License_Number;
    String FullName;
    String Rating;
    String creationDateTxt;
    String finishingDateTxt;
    int identNumber;
    String DeviceToken;
    int DeviceType;
    bool AllowSellOnMap;
    bool AllowSell;
    bool AllowPricing;
    bool Allowbuy;
    bool AllowContractDocument;
    bool AllowMarketting;
    bool IsDesign ;
    bool IsPhoto; 
    bool IsSupport; 
    int GovernmentId;
    int DistrictId;
    int RegionId;
    UserVM({this.Id, this.UserName, this.Email, this.UserImage,this.Phone,this.UserType,this.Commercial_Register,
    this.City,this.Address,this.PasswordHash,this.AllowSellOnMap,this.AllowSell,
    this.AllowPricing,this.Allowbuy,this.AllowContractDocument,this.AllowMarketting,this.ManagerName ,this.License_Number ,
     this.FullName , this.Rating , this.creationDateTxt , this.finishingDateTxt ,
      this.identNumber , this.DeviceToken , this.DeviceType , this.tempUserName , this.Lat , this.Long , this.Long_Lat , 
      this.IsDesign , this.IsPhoto , this.IsSupport  , this.DistrictId , this.GovernmentId , this.RegionId});

    factory UserVM.fromJson(Map<dynamic, dynamic> json) {
      try{
        print("Start Get User");
        //print(json['userType']);print(json['CreationDate']);
      //  print(int.parse(json['rating']));
return UserVM(
           // code: json['code'], 
            Id: json['id'], 
            RegionId: json['regionId'], 
            GovernmentId: json['dovernmentId'], 
            DistrictId: json['districtId'], 
            UserName: json['userName'], 
             Long_Lat: json['long_Lat'],
            Email: json['email'], 
            UserImage: json['userImage'], 
            creationDateTxt:json['creationDateTxt'],
            finishingDateTxt:json['finishingDateTxt'],
            identNumber: int.parse("${json['identNumber']}"),
            DeviceToken:json['deviceToken'],
            DeviceType:json['deviceType'],
            Phone: json['phone'],
            UserType: json['userType'],
            FullName:json['fullName']==null?"":json['fullName'],
            Rating :json['rating'].toString(),
            Commercial_Register: json['commercial_Register'],
            City: json['city'],
            License_Number:json['license_Number'],
            Address: json['Address'],
            ManagerName:json['managerName'],
            PasswordHash:json['PasswordHash'],
            AllowSellOnMap: json['AllowSellOnMap']==null?false:json['AllowSellOnMap'],
            AllowSell: json['AllowSell']==null?false:json['AllowSell'],
            AllowPricing: json['AllowPricing']==null?false:json['AllowPricing'],
            Allowbuy: json['Allowbuy']==null?false:json['Allowbuy'],
            AllowContractDocument: json['AllowContractDocument']==null?false:json['AllowContractDocument'],
            AllowMarketting: json['AllowMarketting']==null?false:json['AllowMarketting'],
            IsDesign: json['IsDesign']==null?false:json['IsDesign'],
            IsPhoto: json['IsPhoto']==null?false:json['IsPhoto'],
            IsSupport: json['IsSupport']==null?false:json['IsSupport'],
            
        );
      }catch(exc){
        print(exc);
return null;
      }
        
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
       // data['code'] = this.code;
        data['Id'] = this.Id;
        data['RegionId'] = this.RegionId;
        data['GovernmentId'] = this.GovernmentId;
        data['DistrictId'] = this.DistrictId;
        data['UserName'] = this.UserName;
        //data['tempUserName'] = this.tempUserName;
        data['FullName']=this.FullName;
        data['creationDateTxt']=this.creationDateTxt;
        data['finishingDateTxt']=this.finishingDateTxt;
        data['identNumber']=this.identNumber;
        data['deviceToken']=this.DeviceToken;
        data['deviceType']=this.DeviceType;
        data['Rating']=this.Rating;
        data['Email'] = this.Email;
        data['UserImage'] = this.UserImage;
        data['UserType'] = this.UserType;
        data['Commercial_Register'] = this.Commercial_Register;
        data['City'] = this.City;
        data['Address'] = this.Address;
        data['PasswordHash']=this.PasswordHash;
        data['AllowSellOnMap'] = this.AllowSellOnMap;
        data['AllowSell'] = this.AllowSell;
        data['AllowPricing'] = this.AllowPricing;
        data['Allowbuy'] = this.Allowbuy;
        data['AllowContractDocument'] = this.AllowContractDocument;
        data['AllowMarketting'] = this.AllowMarketting;
        data['IsDesign'] = this.IsDesign;
        data['IsPhoto'] = this.IsPhoto;
        data['IsSupport'] = this.IsSupport;
        data['managerName']=this.ManagerName;
        return data;
    }
}
//local storage functions
Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
print("Clear shared preffffffff");
print(prefs.getString("Email"));
   //prefs.clear() ;
   
await prefs.remove('Id');
await prefs.remove('UserName');
await prefs.remove('Email');
await prefs.remove('FullName');
await prefs.remove('UserImage');
await prefs.remove('UserType');
await prefs.remove('RegionId');
await prefs.remove('GovernmentId');
await prefs.remove('DistrictId');

    print(prefs.getString("Email"));
    return true ;
}

Future<bool> saveUser(UserVM user) async {
    try {
      print("Start save user");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("Id", user.Id);
        await prefs.setInt("RegionId", user.RegionId);
        await prefs.setInt("GovernmentId", user.GovernmentId);
        await prefs.setInt("DistrictId", user.DistrictId);
        await prefs.setString("UserName", user.UserName);
        await prefs.setString("tempUserName", user.Email);
        await prefs.setString("FullName", user.FullName);
        await prefs.setString("Phone", user.Phone);
        await prefs.setString("creationDateTxt", user.creationDateTxt);
        await prefs.setString("finishingDateTxt", user.finishingDateTxt);
        await prefs.setInt("identNumber", user.identNumber);
        await prefs.setString("deviceToken", user.DeviceToken);
        await prefs.setInt("deviceType", user.DeviceType);

       // await prefs.setInt("Rating", user.Rating);
        await prefs.setString("Email", user.Email);
        await prefs.setString("UserImage", user.UserImage);
        await prefs.setString("UserType", user.UserType);
        await prefs.setString("Commercial_Register", user.Commercial_Register);
        await prefs.setString("City", user.City);
        await prefs.setString("Address", user.Address);
        await prefs.setString("managerName", user.ManagerName);
        
        await prefs.setString("PasswordHash", user.PasswordHash);
        await prefs.setBool("AllowSellOnMap", user.AllowSellOnMap);
        await prefs.setBool("AllowSell", user.AllowSell);
        await prefs.setBool("AllowPricing", user.AllowPricing);
        await prefs.setBool("Allowbuy", user.Allowbuy);
        await prefs.setBool("AllowContractDocument", user.AllowContractDocument);
        await prefs.setBool("AllowMarketting", user.AllowMarketting);
        await prefs.setBool("IsSupport", user.IsSupport);
        await prefs.setBool("IsDesign", user.IsDesign);
        await prefs.setBool("IsPhoto", user.IsPhoto);

        await prefs.setDouble("Long", user.Long);
        await prefs.setDouble("Lat", user.Lat);
        await prefs.setString("Long_Lat", user.Long_Lat);

        return true ;
    }catch(Excption){
        print("save to shared faild   :  $Excption");
        return false ;
    }
}
Future<String> getHistoricalEmail () async{
   final SharedPreferences Prefs = await SharedPreferences.getInstance();
    return  Prefs.getString('tempUserName');
}
Future< UserVM > getUser () async{
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("Email from shared Pref : "+prefs.getString("Email"));
    return new UserVM(
        Id: prefs.getString("Id"),
        GovernmentId: prefs.getInt("GovernmentId"),
        DistrictId: prefs.getInt("DistrictId"),
        RegionId: prefs.getInt("RegionId"),
        UserName: prefs.getString("UserName"),
        tempUserName: prefs.getString("tempUserName"),
        FullName:prefs.getString("FullName"),
        Email: prefs.getString("Email"),
        Phone: prefs.getString("Phone"),
        creationDateTxt:prefs.getString("creationDateTxt"),
        finishingDateTxt:prefs.getString("finishingDateTxt"),
        identNumber:prefs.getInt("identNumber"),
        DeviceToken:prefs.getString("deviceToken"),
       // Rating:prefs.getInt("Rating"),
        UserImage: prefs.getString("UserImage"),
        UserType: prefs.getString("UserType"),
        Commercial_Register: prefs.getString("Commercial_Register"),
        City: prefs.getString("City"),
        Address: prefs.getString("Address"),
        AllowSellOnMap: prefs.getBool("AllowSellOnMap"),
        AllowSell: prefs.getBool("AllowSell"),
        AllowPricing: prefs.getBool("AllowPricing"),
        Allowbuy: prefs.getBool("Allowbuy"),
        AllowContractDocument: prefs.getBool("AllowContractDocument"),
        AllowMarketting: prefs.getBool("AllowMarketting"),
        IsDesign: prefs.getBool("IsDesign"),
        IsPhoto: prefs.getBool("IsPhoto"),
        IsSupport: prefs.getBool("IsSupport"),
        PasswordHash: prefs.getString("PasswordHash"),
        ManagerName:prefs.getString("managerName"),
        DeviceType:prefs.getInt("DeviceType"),

        Long : prefs.getDouble("Long"),
        Lat : prefs.getDouble("Lat"),
        Long_Lat : prefs.getString("Long_Lat")
    );

}