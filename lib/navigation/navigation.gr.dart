// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flick/add_contact/presentation/add_contact_screen.dart' as _i1;
import 'package:flick/app_startup/presentation/app_startup_screen.dart' as _i2;
import 'package:flick/contacts_library/presentation/contacts_library_screen.dart'
    as _i3;
import 'package:flick/onboarding/presentation/onboarding_screen.dart' as _i4;

/// generated route for
/// [_i1.AddContactScreen]
class AddContactRoute extends _i5.PageRouteInfo<void> {
  const AddContactRoute({List<_i5.PageRouteInfo>? children})
    : super(AddContactRoute.name, initialChildren: children);

  static const String name = 'AddContactRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddContactScreen();
    },
  );
}

/// generated route for
/// [_i2.AppStartupScreen]
class AppStartupRoute extends _i5.PageRouteInfo<void> {
  const AppStartupRoute({List<_i5.PageRouteInfo>? children})
    : super(AppStartupRoute.name, initialChildren: children);

  static const String name = 'AppStartupRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppStartupScreen();
    },
  );
}

/// generated route for
/// [_i3.ContactsLibraryScreen]
class ContactsLibraryRoute extends _i5.PageRouteInfo<void> {
  const ContactsLibraryRoute({List<_i5.PageRouteInfo>? children})
    : super(ContactsLibraryRoute.name, initialChildren: children);

  static const String name = 'ContactsLibraryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.ContactsLibraryScreen();
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i5.PageRouteInfo<void> {
  const OnboardingRoute({List<_i5.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingScreen();
    },
  );
}
