
import 'package:shared_preferences/shared_preferences.dart';

class membershipVM {
    int Id;
    String Name;
    String City;
    String Email;
    String Phone;
    String StartDate;
    String EndDate;
    double Rating;
    int MyServices;
    int AllAcceptedServices;
    int AllRefusedServices;
    String ManagerName;
    String Address;
    membershipVM({this.Name,this.StartDate , this.EndDate , this.Rating , this.MyServices 
    , this.AllAcceptedServices , this.Id,this.AllRefusedServices , 
    this.City , this.Email , this.Phone , this.ManagerName , this.Address});

    factory membershipVM.fromJson(Map<String, dynamic> json) {
      print("start fromjson 2222222222 ");
        return membershipVM(
            Id: json['id'], 
             Name: json['name'], 
             City: json['city'], 
             Email: json['email'], 
             ManagerName: json['managerName'] == null?"":json['managerName'], 
             Address: json['address']==null?"":json['address'], 
             Phone: json['phone'], 
            StartDate: json['startDate'],
            EndDate: json['endDate']==null?"":json['endDate'],
            Rating: json['rating'],
            MyServices: json['myServices'],
            AllAcceptedServices: json['allAcceptedServices'],
            AllRefusedServices:json['allRefusedServices']
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Name'] = this.Name;
        data['City'] = this.City;
        data['Email'] = this.Email;
        data['id'] = this.Id;
        data['StartDate'] = this.StartDate;
        data['EndDate'] = this.EndDate;
        data['Rating'] = this.Rating;
        data['MyServices'] = this.MyServices;
        data['allAcceptedServices'] = this.AllAcceptedServices;
        data['allRefusedServices']=this.AllRefusedServices;
        return data;
    }
}



