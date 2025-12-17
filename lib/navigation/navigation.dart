import 'package:auto_route/auto_route.dart';
import 'package:flick/navigation/navigation.gr.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class Navigation extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AppStartupRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: ContactsLibraryRoute.page),
  ];
}
