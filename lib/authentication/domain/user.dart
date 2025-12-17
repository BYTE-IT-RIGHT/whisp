import 'package:hive_ce/hive.dart';

class User extends HiveObject {
  final String username;

  User({required this.username});
}
