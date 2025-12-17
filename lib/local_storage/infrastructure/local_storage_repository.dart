import 'package:flick/authentication/domain/user.dart';
import 'package:flick/local_storage/domain/hive_registrar.g.dart';
import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

enum _Key { USER }

@LazySingleton(as: ILocalStorageRepository)
class LocalStorageRepository implements ILocalStorageRepository {
  late final Box _box;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    _box = await Hive.openBox('flick');
  }

  @override
  User? getUser() => _box.get(_Key.USER);

  @override
  Future<void> setUser(User user) => _box.put(_Key.USER, user);
}
