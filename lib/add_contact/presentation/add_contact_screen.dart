import 'package:auto_route/auto_route.dart';
import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:flick/add_contact/presentation/widgets/add_contact_form.dart';
import 'package:flick/add_contact/presentation/widgets/invite_status_dialog.dart';
import 'package:flick/add_contact/presentation/widgets/qr_code_card.dart';
import 'package:flick/add_contact/presentation/widgets/scan_qr_card.dart';
import 'package:flick/add_contact/presentation/widgets/share_invite_card.dart';
import 'package:flick/common/screens/loading_screen.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/di/injection.dart';
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
        listener: (context, state) {
          switch (state) {
            case AddContactWaiting():
            case AddContactSuccess():
            case AddContactDeclined():
            case AddContactError():
              _showInviteDialog(context, state);
              break;
            case AddContactData():
            default:
              break;
          }
        },
        builder: (context, state) {
          if (state is AddContactLoading) {
            return LoadingScreen();
          }
          final onionAddress = state is AddContactData
              ? state.onionAddress
              : '';
          return StyledScaffold(
            appBar: AppBar(
              title: Text('Add Contact'),
              centerTitle: true,
              elevation: 0,
              notificationPredicate: (_) => false,
            ),
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
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showInviteDialog(BuildContext context, AddContactState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<AddContactCubit>(),
          child: BlocBuilder<AddContactCubit, AddContactState>(
            builder: (context, state) {
              return InviteStatusDialog(
                state: state,
                onClose: () {
                  Navigator.of(dialogContext).pop();
                  if (state is AddContactSuccess) {
                    context.router.maybePop();
                  }
                },
                onRetry: () {
                  Navigator.of(dialogContext).pop();
                  context.read<AddContactCubit>().init();
                },
              );
            },
          ),
        );
      },
    );
  }
}
