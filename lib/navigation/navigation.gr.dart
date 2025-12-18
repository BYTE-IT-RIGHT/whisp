// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:whisp/add_contact/presentation/add_contact_screen.dart' as _i1;
import 'package:whisp/app_startup/presentation/app_startup_screen.dart' as _i2;
import 'package:whisp/chat/presentation/chat_screen.dart' as _i3;
import 'package:whisp/conversations_library/domain/contact.dart' as _i8;
import 'package:whisp/conversations_library/presentation/conversations_library_screen.dart'
    as _i4;
import 'package:whisp/onboarding/presentation/onboarding_screen.dart' as _i5;

/// generated route for
/// [_i1.AddContactScreen]
class AddContactRoute extends _i6.PageRouteInfo<void> {
  const AddContactRoute({List<_i6.PageRouteInfo>? children})
    : super(AddContactRoute.name, initialChildren: children);

  static const String name = 'AddContactRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddContactScreen();
    },
  );
}

/// generated route for
/// [_i2.AppStartupScreen]
class AppStartupRoute extends _i6.PageRouteInfo<void> {
  const AppStartupRoute({List<_i6.PageRouteInfo>? children})
    : super(AppStartupRoute.name, initialChildren: children);

  static const String name = 'AppStartupRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppStartupScreen();
    },
  );
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i6.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i7.Key? key,
    required _i8.Contact contact,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, contact: contact),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i3.ChatScreen(key: args.key, contact: args.contact);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.contact});

  final _i7.Key? key;

  final _i8.Contact contact;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, contact: $contact}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key && contact == other.contact;
  }

  @override
  int get hashCode => key.hashCode ^ contact.hashCode;
}

/// generated route for
/// [_i4.ConversationsLibraryScreen]
class ConversationsLibraryRoute extends _i6.PageRouteInfo<void> {
  const ConversationsLibraryRoute({List<_i6.PageRouteInfo>? children})
    : super(ConversationsLibraryRoute.name, initialChildren: children);

  static const String name = 'ConversationsLibraryRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.ConversationsLibraryScreen();
    },
  );
}

/// generated route for
/// [_i5.OnboardingScreen]
class OnboardingRoute extends _i6.PageRouteInfo<void> {
  const OnboardingRoute({List<_i6.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnboardingScreen();
    },
  );
}
