class LoginModel {
  String? id;
  String? name;
  String? privilege;
  String? login;
  String? password;
  String? userSettingsId;
  String? status;
  String? description;
  String? address;
  String? telephone;
  String? email;
  String? notify;
  String? subaccId;
  String? allowedActions;
  Null? independentExist;
  Null? image;

  LoginModel(
      {this.id,
        this.name,
        this.privilege,
        this.login,
        this.password,
        this.userSettingsId,
        this.status,
        this.description,
        this.address,
        this.telephone,
        this.email,
        this.notify,
        this.subaccId,
        this.allowedActions,
        this.independentExist,
        this.image});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    privilege = json['privilege'];
    login = json['login'];
    password = json['password'];
    userSettingsId = json['userSettings_id'];
    status = json['status'];
    description = json['description'];
    address = json['address'];
    telephone = json['telephone'];
    email = json['email'];
    notify = json['notify'];
    subaccId = json['subacc_id'];
    allowedActions = json['allowed_actions'];
    independentExist = json['independent_exist'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['privilege'] = this.privilege;
    data['login'] = this.login;
    data['password'] = this.password;
    data['userSettings_id'] = this.userSettingsId;
    data['status'] = this.status;
    data['description'] = this.description;
    data['address'] = this.address;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['notify'] = this.notify;
    data['subacc_id'] = this.subaccId;
    data['allowed_actions'] = this.allowedActions;
    data['independent_exist'] = this.independentExist;
    data['image'] = this.image;
    return data;
  }
}
