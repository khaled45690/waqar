

import 'package:shared_preferences/shared_preferences.dart';

class ServiceDataVM {int Id ;
String ServiceName ;int ServiceId ;
String UserId ;
 bool forBuy ;
 bool ForSell ;
 bool ForRent ;
String BuildingType ;
bool IsCommercial ;
bool IsEntertainment;
bool IsEducational;
 bool IsHousing ;
 bool IsManagement ;
String City ;
String Country ;
String District ;
String BuildingAge ;
String BuildingAgeTo;
 double BuildingPrice ;
 double BuildingPriceTo;
String Description ;
String BuildingSize;
String BuildingSizeTo;
 int AddDuration ;
 int AppearingForOffice ;
String PricingPurpose ;
String creationDateTxt;
String Long_Lat ;
 double Long ;
 double Lat ;
 bool IsOwner ;
 bool IsAgent ;
String LessorName ;
String LessorAddress ;
String LessorPhone ;
String LessorEmail ;
String ElectricAccount ;
String BankAccount ;
String TenantName ;
String TenantAddress ;
String TenantPhone ;
String TenantEmail ;
 bool IsCancelled ;
 String filesIds;
 String mainImage;
 List<int>files=null;
 int GovernmentId;
    int DistrictId;
    int RegionId;
    ServiceDataVM({ this.Id ,
this.ServiceName ,
 this.ServiceId ,this.UserId , this.forBuy , this.ForSell , this.ForRent ,this.BuildingType , this.IsCommercial , this.IsHousing ,
this.City ,this.Country ,this.District ,this.BuildingAge , this.BuildingAgeTo , this.BuildingPrice , this.BuildingPriceTo,this.Description , this.AddDuration , 
this.AppearingForOffice ,
this.PricingPurpose ,this.mainImage,
this.Long_Lat , this.Long , this.Lat , this.IsOwner , this.IsAgent ,this.LessorName ,this.LessorAddress ,this.LessorPhone ,
this.LessorEmail ,this.ElectricAccount ,this.BankAccount ,this.TenantName ,this.TenantAddress ,this.TenantPhone ,
this.TenantEmail , this.files,
this.IsCancelled , this.creationDateTxt , this.BuildingSize ,this.BuildingSizeTo, this.filesIds ,
this.IsManagement , this.IsEducational , this.IsEntertainment , this.RegionId , this.DistrictId , this.GovernmentId});

    factory ServiceDataVM.fromJson(Map<String, dynamic> json) {
      print("json['isCommercial']");
      print(json['isCommercial']);
        ServiceDataVM _ServiceDataVM= ServiceDataVM(
            Id: int.parse("${json['id']}"), 
            ServiceId: int.parse("${json['serviceId']}"), 
            ServiceName: json['serviceTxt'], 
            UserId: json['userId'],
            mainImage : json['mainImage'],
            creationDateTxt:json['creationDateTxt'],
            forBuy: json['forBuy']==null?false:json['forBuy'],
            ForSell: json['forSell']==null?false:json['forSell'],
            ForRent: json['forRent']==null?false:json['forRent'],
            BuildingType: json['buildingType'],
            IsCommercial: json['isCommercial'],
            BuildingSize:json['buildingSize'],
            BuildingSizeTo : json['buildingSizeTo'],
            IsHousing: json['isHousing'],
            IsManagement: json['isManagement'],
            IsEducational: json['isEducational']==null?false:json['isEducational'],
            IsEntertainment: json['isEntertainment']==null?false:json['isEntertainment'],
            City: json['city'],
            Country: json['country'],
            District: json['district'],
            BuildingAge: json['buildingAge'],
            BuildingAgeTo : json['buildingAgeTo'],
            BuildingPrice: json['buildingPrice']==null?0:double.parse(json['buildingPrice'].toString()),
            BuildingPriceTo : json['buildingPriceTo']==null?0:double.parse(json['buildingPriceTo'].toString()),
            Description: json['description'],
            AddDuration: json['addDuration'],
            AppearingForOffice: json['appearingForOffice'],
            // PricingPurpose: json['PricingPurpose'],
           Long_Lat: json['long_Lat'],
            // Long: json['Long'],
            // Lat: json['Lat'],
             IsOwner: json['isOwner'] == null?false:json['isOwner'],
             IsAgent: json['isAgent']==null?false:json['isAgent'],
             LessorName: json['lessorName'],
             LessorAddress: json['lessorAddress'],
             LessorPhone: json['lessorPhone'],
             LessorEmail: json['lessorEmail'],
             ElectricAccount: json['electricAccount'],
             BankAccount: json['bankAccount'],
             TenantName: json['tenantName'],
             TenantAddress: json['tenantAddress'],
             TenantPhone: json['tenantPhone'],
             TenantEmail: json['tenantEmail'],
             IsCancelled: json['isCancelled'],
             DistrictId : json['districtId'],
             GovernmentId: json['governmentId'],
             RegionId : json['regionId']
            
        );
        print("IsCommercial Value ----");
    print("Comm "+_ServiceDataVM.IsCommercial.toString());
    print("Hous "+_ServiceDataVM.IsHousing.toString());
    print("Manag "+_ServiceDataVM.IsManagement.toString());
        if(_ServiceDataVM.IsCommercial==null){
          _ServiceDataVM.IsCommercial=false;
        }if(_ServiceDataVM.IsHousing==null){
          _ServiceDataVM.IsHousing=false;
        }if(_ServiceDataVM.IsManagement==null){
          _ServiceDataVM.IsManagement=false;
        }
        return _ServiceDataVM;
    }



// static List<ServiceDataVM> getServicesData() {
//     return <ServiceDataVM>[
//       ServiceDataVM(Id: 1,ServiceName: "Shah 1" , CreationDateTxt:"01/01/2020"),
//       ServiceDataVM(Id: 2,ServiceName: "Shah 2", CreationDateTxt:"01/01/2020"),
//       ServiceDataVM(Id: 3,ServiceName: "Shah 3", CreationDateTxt:"01/01/2020"),
//       ServiceDataVM(Id: 4,ServiceName: "Shah 4", CreationDateTxt:"01/01/2020"),
//       ServiceDataVM(Id: 5,ServiceName: "Shah 5", CreationDateTxt:"01/01/2020"),
//       ServiceDataVM(Id: 6,ServiceName: "Shah 6", CreationDateTxt:"01/01/2020"),
      
//     ];
//   }

    // Map<String, dynamic> toJson() {
    //     final Map<String, dynamic> data = new Map<String, dynamic>();
    //     data['Id'] = this.Id;
    //     data['ServiceId'] = this.ServiceId;
    //     data['UserId'] = this.UserId;
    //     data['NameAr'] = this.NameAr;
    //     data['NameEn'] = this.NameEn;
    //     data['Color1'] = this.Color1;
    //     data['Color2'] = this.Color2;
    //     data['Color3'] = this.Color3;
    //     data['Description'] = this.Description;
    //     data['Phone1'] = this.Phone1;
    //     data['Phone2'] = this.Phone2;
    //     data['Email'] = this.Email;
    //     data['Facebook'] = this.Facebook;
    //     data['Twitter'] = this.Twitter;
    //     data['Instagram'] = this.Instagram;
    //     data['Snapshat'] = this.Snapshat;
    //     data['Youtube'] = this.Youtube;
    //     data['Price'] = this.Price;
        
    //     return data;
    // }
}


