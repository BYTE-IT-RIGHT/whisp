import 'package:flick/authentication/domain/user.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<User>()])
class HiveAdapters {}
