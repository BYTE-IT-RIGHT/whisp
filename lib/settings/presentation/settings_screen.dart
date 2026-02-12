import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/mailbox/application/cubit/mailbox_cubit.dart';
import 'package:whisp/mailbox/presentation/widgets/mailbox_settings_section.dart';

import 'package:whisp/settings/presentation/widgets/local_auth_settings_section.dart';
import 'package:whisp/settings/presentation/widgets/notifications_settings_section.dart';
import 'package:whisp/settings/presentation/widgets/user_settings_section.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MailboxCubit>()..init(),
      child: StyledScaffold(
        appBar: StyledAppBar(title: 'Settings'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserSettingsSection(),
                const SizedBox(height: 32),
                MailboxSettingsSection(),
                const SizedBox(height: 32),
                NotificationsSettingsSection(),
                const SizedBox(height: 32),
                LocalAuthSettingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
