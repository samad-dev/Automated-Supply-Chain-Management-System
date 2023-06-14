class TripRoute {
  String? id;
  String? address;
  String? altitude;
  String? course;
  String? latitude;
  String? longitude;
  String? other;
  String? power;
  String? speed;
  String? time;
  String? valid;
  String? deviceId;
  String? alarmStatus;
  String? imileage;
  String? ikey;
  String? ireason;
  String? ireasoncode;
  String? syscode;
  String? vehicleId;
  String? dtype;
  String? chk1;
  String? vlocation;
  String? overspeed;
  String? recordCreationTime;
  String? recorddate;

  TripRoute(
      {this.id,
        this.address,
        this.altitude,
        this.course,
        this.latitude,
        this.longitude,
        this.other,
        this.power,
        this.speed,
        this.time,
        this.valid,
        this.deviceId,
        this.alarmStatus,
        this.imileage,
        this.ikey,
        this.ireason,
        this.ireasoncode,
        this.syscode,
        this.vehicleId,
        this.dtype,
        this.chk1,
        this.vlocation,
        this.overspeed,
        this.recordCreationTime,
        this.recorddate});

  TripRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    altitude = json['altitude'];
    course = json['course'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    other = json['other'];
    power = json['power'];
    speed = json['speed'];
    time = json['time'];
    valid = json['valid'];
    deviceId = json['device_id'];
    alarmStatus = json['AlarmStatus'];
    imileage = json['imileage'];
    ikey = json['ikey'];
    ireason = json['ireason'];
    ireasoncode = json['ireasoncode'];
    syscode = json['syscode'];
    vehicleId = json['vehicle_id'];
    dtype = json['dtype'];
    chk1 = json['chk1'];
    vlocation = json['vlocation'];
    overspeed = json['overspeed'];
    recordCreationTime = json['record_creation_time'];
    recorddate = json['recorddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['altitude'] = this.altitude;
    data['course'] = this.course;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['other'] = this.other;
    data['power'] = this.power;
    data['speed'] = this.speed;
    data['time'] = this.time;
    data['valid'] = this.valid;
    data['device_id'] = this.deviceId;
    data['AlarmStatus'] = this.alarmStatus;
    data['imileage'] = this.imileage;
    data['ikey'] = this.ikey;
    data['ireason'] = this.ireason;
    data['ireasoncode'] = this.ireasoncode;
    data['syscode'] = this.syscode;
    data['vehicle_id'] = this.vehicleId;
    data['dtype'] = this.dtype;
    data['chk1'] = this.chk1;
    data['vlocation'] = this.vlocation;
    data['overspeed'] = this.overspeed;
    data['record_creation_time'] = this.recordCreationTime;
    data['recorddate'] = this.recorddate;
    return data;
  }
}
