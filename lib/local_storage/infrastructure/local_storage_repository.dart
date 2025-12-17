import 'package:flick/local_storage/domain/i_local_storage_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalStorageRepository)
class LocalStorageRepository implements ILocalStorageRepository {}