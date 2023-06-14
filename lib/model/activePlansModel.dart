class ActivePlans {
  String? id;
  String? sapNo;
  String? geocor;
  String? initialTime;
  String? customer;
  String? depot;
  String? vehicle;
  String? product;
  String? qty;
  String? tripstarttime;
  String? tripendtime;
  String? positionid;
  String? status;
  String? customername;
  String? vehiclename;
  String? trackerstatus;
  Null? commets;

  ActivePlans(
      {this.id,
        this.sapNo,
        this.geocor,
        this.initialTime,
        this.trackerstatus,
        this.customer,
        this.depot,
        this.vehicle,
        this.product,
        this.qty,
        this.tripstarttime,
        this.tripendtime,
        this.positionid,
        this.status,
        this.customername,
        this.vehiclename,
        this.commets});

  ActivePlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sapNo = json['sap_no'];
    geocor = json['geocor'];
    trackerstatus = json['trackerstatus'];
    initialTime = json['initial_time'];
    customer = json['customer'];
    depot = json['depot'];
    vehicle = json['vehicle'];
    product = json['product'];
    qty = json['qty'];
    tripstarttime = json['tripstarttime'];
    tripendtime = json['tripendtime'];
    positionid = json['positionid'];
    status = json['status'];
    customername = json['customername'];
    vehiclename = json['vehiclename'];
    commets = json['commets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackerstatus'] = this.trackerstatus;
    data['geocor'] = this.geocor;
    data['sap_no'] = this.sapNo;
    data['initial_time'] = this.initialTime;
    data['customer'] = this.customer;
    data['depot'] = this.depot;
    data['vehicle'] = this.vehicle;
    data['product'] = this.product;
    data['qty'] = this.qty;
    data['tripstarttime'] = this.tripstarttime;
    data['tripendtime'] = this.tripendtime;
    data['positionid'] = this.positionid;
    data['status'] = this.status;
    data['customername'] = this.customername;
    data['vehiclename'] = this.vehiclename;
    data['commets'] = this.commets;
    return data;
  }
}
