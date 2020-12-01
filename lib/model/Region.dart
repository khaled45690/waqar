class Region {
  int regionId;
  String regionName;
  int showOrder;
  List<Governments> governments;

  Region({this.regionId, this.regionName, this.showOrder, this.governments});

  Region.fromJson(Map<String, dynamic> json) {
    regionId = json['regionId'];
    regionName = json['regionName'];
    showOrder = json['showOrder'];
    if (json['governments'] != null) {
      governments = new List<Governments>();
      json['governments'].forEach((v) {
        governments.add(new Governments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Region = new Map<String, dynamic>();
    Region['regionId'] = this.regionId;
    Region['regionName'] = this.regionName;
    Region['showOrder'] = this.showOrder;
    if (this.governments != null) {
      Region['governments'] = this.governments.map((v) => v.toJson()).toList();
    }
    return Region;
  }
}

class Governments {
  int governmentId;
  String governmentName;
  int showOrder;
  int regionId;
  List<Districts> districts;

  Governments(
      {this.governmentId,
      this.governmentName,
      this.showOrder,
      this.regionId,
      this.districts});

  Governments.fromJson(Map<String, dynamic> json) {
    governmentId = json['governmentId'];
    governmentName = json['governmentName'];
    showOrder = json['showOrder'];
    regionId = json['regionId'];
    if (json['districts'] != null) {
      districts = new List<Districts>();
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Region = new Map<String, dynamic>();
    Region['governmentId'] = this.governmentId;
    Region['governmentName'] = this.governmentName;
    Region['showOrder'] = this.showOrder;
    Region['regionId'] = this.regionId;
    if (this.districts != null) {
      Region['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return Region;
  }
}

class Districts {
  int districtId;
  String districtName;
  int showOrder;
  int governmentId;

  Districts(
      {this.districtId, this.districtName, this.showOrder, this.governmentId});

  Districts.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    districtName = json['districtName'];
    showOrder = json['showOrder'];
    governmentId = json['governmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Region = new Map<String, dynamic>();
    Region['districtId'] = this.districtId;
    Region['districtName'] = this.districtName;
    Region['showOrder'] = this.showOrder;
    Region['governmentId'] = this.governmentId;
    return Region;
  }
}