import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 0)
class HiveUser {
  @HiveField(0)
  String phoneNumber;
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  List contacts;
  @HiveField(4)
  String profilePictureName;
  @HiveField(5)
  int showLastSeen;
  @HiveField(6)
  String about = 'Hey there, I am new on WhatsApp.';
}