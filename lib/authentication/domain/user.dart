import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:hive_ce/hive.dart';

class User extends HiveObject {
  final String username;
  final String onionAddress;
  final String avatarUrl;

  User({
    required this.username,
    required this.onionAddress,
    required this.avatarUrl,
  });

  Contact toContact() => Contact(
    onionAddress: onionAddress,
    username: username,
    avatarUrl: avatarUrl,
  );
}
