import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository_only_get.dart';

abstract class GenFirebaseRepositoryOnlyGet<T, ID>
    extends IListenerRepositoryOnlyGet<T, ID, String> {
  String get collectionName;
  String get listName;
  String get idName;

  T fromJson(Map<String, dynamic> json);

  StreamSubscription<DocumentSnapshot>? listenerStream;

  Future<MapEntry<DocumentReference<Object?>, DocumentSnapshot<Object?>?>>
      getRefAndSnapshot({required String idc}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(idc);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error getting data of $idc from $collectionName");
    }
  }

  bool checkIfDocExists(DocumentSnapshot<Object?>? snapshot) {
    return snapshot == null || !snapshot.exists || snapshot.data() == null;
  }

  @override
  void addListener({
    required String idc,
    required Function(List<T>) listener,
  }) {
    listenerStream = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(idc)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (checkIfDocExists(snapshot)) return;
      var data = snapshot.data() as Map<String, dynamic>;
      var entities = (data[listName] as List<dynamic>)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
      listener(entities);
    });
  }

  @override
  Future<bool> existsById({
    required ID id,
    required String idc,
  }) async {
    return await findById(id: id, idc: idc) != null;
  }

  @override
  Future<List<T>> findAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return [];
    var data = docRef.value!.data() as Map<String, dynamic>;
    return (data[listName] as List<dynamic>)
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<T?> findById({
    required ID id,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return null;
    var data = docRef.value!.data() as Map<String, dynamic>;
    var entity = (data[listName] as List<dynamic>)
        .firstWhere((task) => task[idName] == id, orElse: () => null);
    if (entity == null) return null;
    return fromJson(entity as Map<String, dynamic>);
  }

  @override
  void removeListener({required String idc}) {
    listenerStream?.cancel();
  }
}
