import 'package:hive/hive.dart';

part 'hive_contact.g.dart';

@HiveType(typeId: 1)
class HiveContact {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  String about;
  @HiveField(3)
  bool isInContactList;
  @HiveField(4)
  bool haveProfilePicture = false;
}