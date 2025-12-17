// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flick/app_startup/presentation/app_startup_screen.dart' as _i1;
import 'package:flick/onboarding/onboarding_screen.dart' as _i2;

/// generated route for
/// [_i1.AppStartupScreen]
class AppStartupRoute extends _i3.PageRouteInfo<void> {
  const AppStartupRoute({List<_i3.PageRouteInfo>? children})
    : super(AppStartupRoute.name, initialChildren: children);

  static const String name = 'AppStartupRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppStartupScreen();
    },
  );
}

/// generated route for
/// [_i2.OnboardingScreen]
class OnboardingRoute extends _i3.PageRouteInfo<void> {
  const OnboardingRoute({List<_i3.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.OnboardingScreen();
    },
  );
}
