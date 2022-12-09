// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhst/appointments/models/appointment.dart';
import 'package:rhst/appointments/models/carpool.dart';

class AppointmentsRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Appointment>> getAllAppointments() async {
    List<Future<Appointment>> results = [];
    await _firestore
        .collection("appointments")
        .get()
        .then((snap) => snap.docs.forEach((doc) => results.add(_mapFirebaseToAppointment(doc))));
    return Future.wait(results);
  }

  Future<void> upsertAppointment(String userId, Appointment appointment) {
    if (appointment.id != null) {
      return _firestore.doc("appointments/${appointment.id}").update(appointment.toJson());
    } else {
      return _firestore.collection("appointments").add(appointment.toJson());
    }
  }

  Future<void> createCarpool(String appointmentId, Carpool carpool) {
    return _firestore.collection("appointments/$appointmentId/carpools").add(carpool.toJson());
  }

  Future<void> joinAppointment({
    required String appointmentId,
    required String participatingHumanId,
    required List<String> participatingDogIds,
    required Carpool carpool,
  }) async {
    List<Future<void>> futures = [];

    // add humans & dogs to appointment itself
    futures.add(_addHumanToAppointment(
      appointmentId: appointmentId,
      humanId: participatingHumanId,
    ));

    for (var dogId in participatingDogIds) {
      futures.add(_addDogToAppointment(
        appointmentId: appointmentId,
        dogId: dogId,
      ));
    }

    // add humans & dogs to carpool
    String? carpoolId = carpool.id;

    // driving solo || new carpool --> create a new carpool
    if (carpoolId == null) {
      final newDocRef =
          await _firestore.collection("appointments/$appointmentId/carpools").add(carpool.toJson());
      carpoolId = newDocRef.id;
    }

    futures.add(_addHumanToCarpool(
      appointmentId: appointmentId,
      carpoolId: carpoolId,
      humanId: participatingHumanId,
    ));

    for (var dogId in participatingDogIds) {
      futures.add(_addDogToCarpool(
        appointmentId: appointmentId,
        carpoolId: carpoolId,
        dogId: dogId,
      ));
    }

    return Future.wait(futures).then((_) => null);
  }

  Future<List<Carpool>> getCarpoolsOfAppointment(String appointmentId) {
    return _firestore
        .collection("appointments/$appointmentId/carpools")
        .get()
        .then((snap) => snap.docs.map((d) => Carpool.fromJson(d.data(), id: d.id)).toList());
  }

  Future<Appointment> _mapFirebaseToAppointment(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    final data = doc.data();
    final carpools = await getCarpoolsOfAppointment(doc.id);

    return Appointment(
      id: doc.id,
      title: data["title"],
      description: data["description"],
      timeFrom: data["timeFrom"],
      timeUntil: data["timeUntil"],
      location: data["location"],
      authorId: data["authorId"],
      carpools: carpools,
    );
  }

// helper functions
  Future<void> _addHumanToCarpool(
          {required String appointmentId, required String carpoolId, required String humanId}) =>
      _firestore
          .doc("appointments/$appointmentId/carpools/$carpoolId/participatingHumans/$humanId")
          .set({"joinedAt": Timestamp.now()});

  Future<void> _addDogToCarpool(
          {required String appointmentId, required String carpoolId, required String dogId}) =>
      _firestore
          .doc("appointments/$appointmentId/carpools/$carpoolId/participatingDogs/$dogId")
          .set({"joinedAt": Timestamp.now()});

  Future<void> _addHumanToAppointment({required String appointmentId, required String humanId}) =>
      _firestore
          .doc("appointments/$appointmentId/participatingHumans/$humanId")
          .set({"joinedAt": Timestamp.now()});

  Future<void> _addDogToAppointment({required String appointmentId, required String dogId}) =>
      _firestore
          .doc("appointments/$appointmentId/participatingDogs/$dogId")
          .set({"joinedAt": Timestamp.now()});
}
