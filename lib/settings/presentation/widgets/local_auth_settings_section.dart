import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/local_auth/presentation/dialogs/pin_input_dialog.dart';
import 'package:whisp/settings/presentation/widgets/section_header.dart';
import 'package:whisp/settings/presentation/widgets/settings_switch.dart';

class LocalAuthSettingsSection extends StatelessWidget {
  const LocalAuthSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthCubit, LocalAuthState>(
      builder: (context, state) => Column(
        children: [
          SectionHeader(title: 'Biometric Authentication'),
          const SizedBox(height: 12),
          SettingsSwitch(
            title: 'Biometric Authentication',
            subtitle: 'Require authentication to access the app',
            value: state.isEnabled,
            onChanged: (value) async {
              if (!state.isDeviceSupported) return;
              final pin = state.hasPin
                  ? null
                  : await PinInputDialog.show(context, true);

              if (!state.hasPin && pin == null) return;
              if (!context.mounted) return;
              final authenticated = await context
                  .read<LocalAuthCubit>()
                  .authenticate(force: true);
              if (!context.mounted || !authenticated) return;

              final cubit = context.read<LocalAuthCubit>();
              if (pin != null) cubit.setPin(pin);
              cubit.toggleLocalAuth(value);
            },
          ),
          const SizedBox(height: 12),
          SettingsSwitch(
            title: 'Require Authentication on Pause',
            subtitle:
                'Require authentication to access the app when the app is paused',
            value: state.requireAuthenticationOnPause,
            onChanged: (value) {
              context.read<LocalAuthCubit>().toggleRequireAuthenticationOnPause(
                value,
              );
            },
          ),
        ],
      ),
    );
  }
}
