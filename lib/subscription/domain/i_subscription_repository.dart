import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:whisp/common/domain/failure.dart';

abstract class ISubscriptionRepository {
  Future<void> init();
  Future<Either<Failure, CustomerInfo>> getCustomerInfo();
  Future<Either<Failure, Unit>> presentPaywall();
}
