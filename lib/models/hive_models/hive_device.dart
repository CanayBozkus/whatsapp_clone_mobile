import 'package:hive/hive.dart';

part 'hive_device.g.dart';

@HiveType(typeId: 2)
class HiveDevice {
  @HiveField(0)
  int lastCheckedContactCount = 0;
}