class DoctorModel {
  final String? uid;
  final String? name;
  final String? specialization;
  final String? email;
  final String? phone1;
  final String? phone2;
  final String? bio;
  final String? address;
  final String? openingHours;
  final String? clossingHours;
  final String? image;
  final double? rating;

  DoctorModel({
    this.uid,
    this.name,
    this.specialization,
    this.email,
    this.phone1,
    this.phone2,
    this.bio,
    this.address,
    this.openingHours,
    this.clossingHours,
    this.image,
    this.rating,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      rating: json['rating']?.toDouble(),
      uid: json['uid'],
      name: json['name'],
      specialization: json['specialization'],
      email: json['email'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      bio: json['bio'],
      address: json['address'],
      openingHours: json['openingHours'],
      clossingHours: json['clossingHours'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'specialization': specialization,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'bio': bio,
      'address': address,
      'openingHours': openingHours,
      'clossingHours': clossingHours,
      'image': image,
      'rating': rating,
    };
  }

  Map<String, dynamic> upUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (specialization != null) data['specialization'] = specialization;
    if (email != null) data['email'] = email;
    if (phone1 != null) data['phone1'] = phone1;
    if (phone2 != null) data['phone2'] = phone2;
    if (bio != null) data['bio'] = bio;
    if (address != null) data['address'] = address;
    if (openingHours != null) data['openingHours'] = openingHours;
    if (clossingHours != null) data['clossingHours'] = clossingHours;
    if (image != null) data['image'] = image;
    if (rating != null) data['rating'] = rating;
    return data;
  }
}
