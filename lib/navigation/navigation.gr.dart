// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flick/app_startup/presentation/app_startup_screen.dart' as _i1;
import 'package:flick/contacts_library/presentation/contacts_library_screen.dart'
    as _i2;
import 'package:flick/onboarding/presentation/onboarding_screen.dart' as _i3;

/// generated route for
/// [_i1.AppStartupScreen]
class AppStartupRoute extends _i4.PageRouteInfo<void> {
  const AppStartupRoute({List<_i4.PageRouteInfo>? children})
    : super(AppStartupRoute.name, initialChildren: children);

  static const String name = 'AppStartupRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppStartupScreen();
    },
  );
}

/// generated route for
/// [_i2.ContactsLibraryScreen]
class ContactsLibraryRoute extends _i4.PageRouteInfo<void> {
  const ContactsLibraryRoute({List<_i4.PageRouteInfo>? children})
    : super(ContactsLibraryRoute.name, initialChildren: children);

  static const String name = 'ContactsLibraryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.ContactsLibraryScreen();
    },
  );
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i4.PageRouteInfo<void> {
  const OnboardingRoute({List<_i4.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.OnboardingScreen();
    },
  );
}
