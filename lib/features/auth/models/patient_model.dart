class PatientModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? phone1;
  final String? phone2;
  

  PatientModel({
    this.uid,
    this.name,
    this.email,
    this.phone1,
    this.phone2,
    
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      
    };
  }

  Map<String, dynamic> upUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone1 != null) data['phone1'] = phone1;
    if (phone2 != null) data['phone2'] = phone2;
    
    return data;
  }
}
