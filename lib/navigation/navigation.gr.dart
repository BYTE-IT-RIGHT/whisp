// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:whisp/add_contact/presentation/add_contact_screen.dart' as _i1;
import 'package:whisp/app_startup/presentation/app_startup_screen.dart' as _i2;
import 'package:whisp/chat/presentation/chat_screen.dart' as _i3;
import 'package:whisp/conversations_library/domain/contact.dart' as _i11;
import 'package:whisp/conversations_library/presentation/conversations_library_screen.dart'
    as _i4;
import 'package:whisp/invitation/presentation/invitation_screen.dart' as _i5;
import 'package:whisp/messaging/domain/message.dart' as _i12;
import 'package:whisp/onboarding/presentation/onboarding_screen.dart' as _i6;
import 'package:whisp/settings/presentation/settings_screen.dart' as _i7;
import 'package:whisp/tutorial/presentation/tutorial_screen.dart' as _i8;

/// generated route for
/// [_i1.AddContactScreen]
class AddContactRoute extends _i9.PageRouteInfo<void> {
  const AddContactRoute({List<_i9.PageRouteInfo>? children})
    : super(AddContactRoute.name, initialChildren: children);

  static const String name = 'AddContactRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddContactScreen();
    },
  );
}

/// generated route for
/// [_i2.AppStartupScreen]
class AppStartupRoute extends _i9.PageRouteInfo<void> {
  const AppStartupRoute({List<_i9.PageRouteInfo>? children})
    : super(AppStartupRoute.name, initialChildren: children);

  static const String name = 'AppStartupRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppStartupScreen();
    },
  );
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i9.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i10.Key? key,
    required _i11.Contact contact,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, contact: contact),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i3.ChatScreen(key: args.key, contact: args.contact);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.contact});

  final _i10.Key? key;

  final _i11.Contact contact;

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
class ConversationsLibraryRoute extends _i9.PageRouteInfo<void> {
  const ConversationsLibraryRoute({List<_i9.PageRouteInfo>? children})
    : super(ConversationsLibraryRoute.name, initialChildren: children);

  static const String name = 'ConversationsLibraryRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.ConversationsLibraryScreen();
    },
  );
}

/// generated route for
/// [_i5.InvitationScreen]
class InvitationRoute extends _i9.PageRouteInfo<InvitationRouteArgs> {
  InvitationRoute({
    _i10.Key? key,
    required _i12.Message invitation,
    required dynamic Function() onAccept,
    required dynamic Function() onDecline,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         InvitationRoute.name,
         args: InvitationRouteArgs(
           key: key,
           invitation: invitation,
           onAccept: onAccept,
           onDecline: onDecline,
         ),
         initialChildren: children,
       );

  static const String name = 'InvitationRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvitationRouteArgs>();
      return _i5.InvitationScreen(
        key: args.key,
        invitation: args.invitation,
        onAccept: args.onAccept,
        onDecline: args.onDecline,
      );
    },
  );
}

class InvitationRouteArgs {
  const InvitationRouteArgs({
    this.key,
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
  });

  final _i10.Key? key;

  final _i12.Message invitation;

  final dynamic Function() onAccept;

  final dynamic Function() onDecline;

  @override
  String toString() {
    return 'InvitationRouteArgs{key: $key, invitation: $invitation, onAccept: $onAccept, onDecline: $onDecline}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InvitationRouteArgs) return false;
    return key == other.key && invitation == other.invitation;
  }

  @override
  int get hashCode => key.hashCode ^ invitation.hashCode;
}

/// generated route for
/// [_i6.OnboardingScreen]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i8.TutorialScreen]
class TutorialRoute extends _i9.PageRouteInfo<void> {
  const TutorialRoute({List<_i9.PageRouteInfo>? children})
    : super(TutorialRoute.name, initialChildren: children);

  static const String name = 'TutorialRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.TutorialScreen();
    },
  );
}
