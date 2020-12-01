

class ContactUsVM {
    String facebook;
    String website;
    String email="";
    String phone="";
    String shareApp="";
    ContactUsVM({this.facebook,this.website, this.email, this.phone ,this.shareApp});

    factory ContactUsVM.fromJson(Map<String, dynamic> json) {
        return ContactUsVM(
            facebook: json['facebook'], 
            website: json['website'], 
            email: json['email'], 
            phone: json['phone'],
            shareApp:json['shareApp']
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['facebook'] = this.facebook;
        data['website'] = this.website;
        data['email'] = this.email;
        data['phone'] = this.phone;
        data['shareApp'] = this.shareApp;
        return data;
    }
}

