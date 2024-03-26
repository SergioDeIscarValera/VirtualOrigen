import 'dart:async';
import 'dart:convert';

import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository_only_get.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository.dart';

abstract class GenFirebaseRepository<T, ID>
    extends GenFirebaseRepositoryOnlyGet<T, ID>
    implements IListenerRepository<T, ID, String> {
  @override
  Future<void> deleteAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return;
    await docRef.key.update({listName: []});
  }

  @override
  Future<void> deleteAllWhere({
    required List<ID> ids,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return;
    var data = docRef.value!.data() as Map<String, dynamic>;
    var entities = data[listName] as List<dynamic>;
    entities.removeWhere((entity) => ids.contains(entity[idName]));
    await docRef.key.update({listName: entities});
  }

  @override
  Future<void> deleteById({
    required ID id,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return;
    var data = docRef.value!.data() as Map<String, dynamic>;
    var entities = data[listName] as List<dynamic>;
    entities.removeWhere((entity) => entity[idName] == id);
    await docRef.key.update({listName: entities});
  }

  @override
  Future<T?> save({
    required T entity,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) {
      await docRef.key.set({
        listName: [toJson(entity)]
      });
      return entity;
    }
    var data = docRef.value!.data() as Map<String, dynamic>;
    var entities = data[listName] as List<dynamic>;
    var pos = entities
        .indexWhere((element) => element[idName] == toJson(entity)[idName]);
    entities
        .removeWhere((element) => element[idName] == toJson(entity)[idName]);
    if (pos != -1) {
      entities.insert(pos, toJson(entity));
    } else {
      entities.add(toJson(entity));
    }
    await docRef.key.update({listName: entities});
    return entity;
  }

  @override
  Future<List<T>?> saveAll({
    required List<T> entities,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) {
      await docRef.key.set({listName: entities.map((e) => toJson(e)).toList()});
      return entities;
    }
    var data = docRef.value!.data() as Map<String, dynamic>;
    var oldEntities = data[listName] as List<dynamic>;
    oldEntities.removeWhere((element) => entities
        .map((e) => jsonDecode(e as dynamic)[idName])
        .contains(jsonDecode(element)[idName]));
    oldEntities.addAll(entities.map((e) => toJson(e)).toList());
    await docRef.key.update({listName: oldEntities});
    return entities;
  }
}
