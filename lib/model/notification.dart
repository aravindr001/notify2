import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 1)
class NotificationDataModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  @HiveField(2)
  String packageName;

  @HiveField(3)
  String createAt;

  NotificationDataModel(
      {required this.title,required this.text, required this.packageName, required this.createAt});
}
