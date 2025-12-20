import 'package:auto_route/auto_route.dart';
import 'package:whisp/navigation/navigation.gr.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class Navigation extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AppStartupRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: ConversationsLibraryRoute.page),
    AutoRoute(page: AddContactRoute.page),
    AutoRoute(page: ChatRoute.page),
  ];
}
