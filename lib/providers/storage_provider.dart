import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/storage_item.dart';


class StorageProvider extends ChangeNotifier {
  final Box<StorageItem> box;
  String _query = '';


  StorageProvider(this.box);


  List<StorageItem> get items {
    if (_query.isEmpty) return box.values.toList();
    return box.values
        .where((e) =>
    e.name.toLowerCase().contains(_query) ||
        e.location.toLowerCase().contains(_query))
        .toList();
  }


  void search(String value) {
    _query = value.toLowerCase();
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    notifyListeners();
  }


/*
  Future<void> add(StorageItem item) async {
    await box.put(item.id, item);
    await box.flush();
    debugPrint('ADDED -> id=${item.id} length=${box.length}');
    notifyListeners();
  }
*/

  Future<void> add(StorageItem item) async {
    await box.add(item); // ✅ clé String
    await box.flush();
    notifyListeners();
  }


  Future<void> update(StorageItem item) async {
    await item.save();
    await box.flush();
    notifyListeners();
  }


  Future<void> delete(StorageItem item) async {
    await item.delete();
    await box.flush();
    notifyListeners();
  }
}