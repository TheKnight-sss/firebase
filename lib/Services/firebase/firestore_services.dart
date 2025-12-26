import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/features/patient/booking/data/appoitment_model.dart';

class FirestoreServices {
  static final CollectionReference _doctorsCollection = FirebaseFirestore
      .instance
      .collection('doctors');
  static final CollectionReference _patiensCollection = FirebaseFirestore
      .instance
      .collection('patiens');
  static Future<QuerySnapshot> sortDoctorsByRating() {
    return _doctorsCollection
        .orderBy("rating", descending: true)
        .where("specialization", isNull: false)
        .get();
  }

  static Future<QuerySnapshot> filterDoctorsBySpecilization(
    String specialization,
  ) {
    return _doctorsCollection
        .orderBy('rating', descending: true)
        .where("specialization", isEqualTo: specialization, isNull: false)
        .get();
  }

  static Future<QuerySnapshot> getDoctorByName(String searchkey) {
    return _doctorsCollection
        .orderBy('name')
        .orderBy('rating', descending: true)
        .startAt([searchkey])
        .endAt(['$searchkey\uf8ff'])
        .get();
  }

  static Future<void> createAppointment(AppointmentModel appointment) {
    return _patiensCollection.doc(appointment.id).set(appointment.toJson());
  }
}
