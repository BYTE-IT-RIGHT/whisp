import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:whisp/common/constants/secrets.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/subscription/domain/i_subscription_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepository implements ISubscriptionRepository {
  @override
  Future<void> init() async {
    String apiKey;
    if (Platform.isIOS) {
      apiKey = Secrets.revenueCatApiKeyIos;
    } else if (Platform.isAndroid) {
      apiKey = Secrets.revenueCatApiKeyAndroid;
    } else {
      throw UnsupportedError('Platform not supported');
    }

    log('fdsfds');

    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  @override
  Future<Either<Failure, CustomerInfo>> getCustomerInfo() {
    // TODO: implement getCustomerInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> presentPaywall() async {
    try {
      final paywallResult = await RevenueCatUI.presentPaywall();
      print(paywallResult);
      return right(unit);
    } catch (e) {
      log('presentPaywall unexpected error: $e');
      return left(UnexpectedError());
    }
  }
}
