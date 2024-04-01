import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository_only_get.dart';

class InversorNowFirebaseRepository
    extends GenFirebaseRepositoryOnlyGet<InversorNow, String> {
  @override
  String get collectionName => "inversor_now";

  @override
  String get idName => throw UnimplementedError();

  @override
  String get listName => throw UnimplementedError();

  @override
  InversorNow fromJson(Map<String, dynamic> json) {
    return InversorNow(
      battery: json["battery"],
      consumption: json["consumption"],
      gain: json["gain"],
    );
  }

  @override
  void addListener(
      {required String idc, required Function(List<InversorNow>) listener}) {
    listenerStream = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(idc)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (checkIfDocExists(snapshot)) return;
      var data = snapshot.data() as Map<String, dynamic>;
      var entity = fromJson(data);
      listener([entity]);
    });
  }

  @override
  Future<List<InversorNow>> findAll({required String idc}) async {
    var data = await findById(id: idc, idc: idc);
    return data != null ? [data] : [];
  }

  @override
  Future<InversorNow?> findById(
      {required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return null;
    var data = docRef.value!.data() as Map<String, dynamic>;
    return fromJson(data);
  }
}
