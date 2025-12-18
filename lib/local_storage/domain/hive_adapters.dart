import 'package:whisp/authentication/domain/user.dart';
import 'package:whisp/conversations_library/domain/contact.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<User>(), AdapterSpec<Contact>()])
class HiveAdapters {}
