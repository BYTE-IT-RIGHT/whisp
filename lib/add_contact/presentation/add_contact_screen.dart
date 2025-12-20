import 'package:auto_route/auto_route.dart';
import 'package:whisp/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:whisp/add_contact/presentation/widgets/add_contact_form.dart';
import 'package:whisp/add_contact/presentation/widgets/invite_status_dialog.dart';
import 'package:whisp/add_contact/presentation/widgets/qr_code_card.dart';
import 'package:whisp/add_contact/presentation/widgets/scan_qr_card.dart';
import 'package:whisp/add_contact/presentation/widgets/share_invite_card.dart';
import 'package:whisp/common/screens/loading_screen.dart';
import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddContactCubit>()..init(),
      child: BlocConsumer<AddContactCubit, AddContactState>(
        listenWhen: (previous, current) {
          // Only show dialog when transitioning TO AddContactWaiting
          // (not for subsequent state changes within the dialog)
          return current is AddContactWaiting && previous is! AddContactWaiting;
        },
        listener: (context, state) {
          _showInviteDialog(context);
        },
        builder: (context, state) {
          if (state is AddContactLoading) {
            return LoadingScreen();
          }
          final onionAddress = state is AddContactData
              ? state.onionAddress
              : '';
          return StyledScaffold(
            appBar: StyledAppBar(title: 'Add Contact'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ShareInviteCard(onionAddress: onionAddress),
                  const SizedBox(height: 24),
                  QrCodeCard(data: onionAddress),
                  const SizedBox(height: 24),
                  AddContactForm(),
                  const SizedBox(height: 24),
                  ScanQrCard(),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<AddContactCubit>(),
          child: BlocBuilder<AddContactCubit, AddContactState>(
            buildWhen: (previous, current) {
              // Only rebuild for dialog-relevant states
              return current is AddContactWaiting ||
                  current is AddContactSuccess ||
                  current is AddContactDeclined ||
                  current is AddContactError;
            },
            builder: (context, state) {
              return InviteStatusDialog(
                state: state,
                onClose: () {
                  Navigator.of(dialogContext).pop();
                  context.read<AddContactCubit>().init();
                },
                onRetry: () {
                  final onionAddress = switch (state) {
                    AddContactDeclined(:final onionAddress) => onionAddress,
                    AddContactError(:final onionAddress) => onionAddress,
                    _ => null,
                  };
                  if (onionAddress != null) {
                    context.read<AddContactCubit>().addContact(onionAddress);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
