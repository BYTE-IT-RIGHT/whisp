import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/notifications/application/cubit/notifications_cubit.dart';
import 'package:whisp/settings/presentation/widgets/section_header.dart';
import 'package:whisp/settings/presentation/widgets/settings_switch.dart';

class NotificationsSettingsSection extends StatelessWidget {
  const NotificationsSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) => Column(
        children: [
          SectionHeader(title: 'Notifications'),
          const SizedBox(height: 12),
          SettingsSwitch(
            title: 'Message Notifications',
            subtitle: 'Show notifications for incoming messages',
            value: state.notificationsEnabled,
            onChanged: (value) =>
                context.read<NotificationsCubit>().toggleNotifications(value),
          ),
          const SizedBox(height: 12),
          SettingsSwitch(
            title: 'Background Connection',
            subtitle: 'Show notification when connected in background',
            value: state.foregroundServiceEnabled,
            onChanged: (value) => context
                .read<NotificationsCubit>()
                .toggleForegroundService(value),
          ),
        ],
      ),
    );
  }
}
