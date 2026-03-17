import 'package:hive/hive.dart';

part 'storage_item.g.dart';


@HiveType(typeId: 0)
class StorageItem extends HiveObject {
  @HiveField(0)
  int id;


  @HiveField(1)
  String name;


  @HiveField(2)
  String location;


  @HiveField(3)
  String note;


  StorageItem({
    required this.id,
    required this.name,
    required this.location,
    required this.note,
  });
}