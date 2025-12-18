import 'package:flick/conversations_library/domain/contact.dart';
import 'package:hive_ce/hive.dart';

class User extends HiveObject {
  final String username;
  final String onionAddress;

  User({required this.username, required this.onionAddress});

  Contact toContact() =>
      Contact(onionAddress: onionAddress, username: username);
}
