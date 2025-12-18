import 'package:auto_route/auto_route.dart';
import 'package:flick/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:flick/common/domain/failure.dart';
import 'package:flick/common/screens/loading_screen.dart';
import 'package:flick/common/widgets/styled_scaffold.dart';
import 'package:flick/di/injection.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _addressController = TextEditingController();

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
              : null;
          return _buildDataScreen(context, onionAddress ?? '');
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
              return _InviteStatusDialog(
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

  Widget _buildDataScreen(BuildContext context, String onionAddress) {
    return StyledScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your Onion Address'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FittedBox(child: Text(onionAddress, maxLines: 1)),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: onionAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Contact Onion Address',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<AddContactCubit>().addContact(
                _addressController.text,
              ),
              child: const Text('Send invite'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteStatusDialog extends StatelessWidget {
  final AddContactState state;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  const _InviteStatusDialog({
    required this.state,
    required this.onClose,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.flickTheme;

    return Dialog(
      backgroundColor: theme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 16),
            _buildTitle(theme),
            const SizedBox(height: 8),
            _buildSubtitle(theme),
            const SizedBox(height: 24),
            _buildActions(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return switch (state) {
      AddContactWaiting() => const SizedBox(
        width: 64,
        height: 64,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
      AddContactSuccess() => const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 64,
      ),
      AddContactDeclined() => const Icon(
        Icons.cancel,
        color: Colors.red,
        size: 64,
      ),
      AddContactError() => const Icon(
        Icons.error_outline,
        color: Colors.orange,
        size: 64,
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildTitle(FlickTheme theme) {
    final text = switch (state) {
      AddContactWaiting() => 'Invitation Pending',
      AddContactSuccess() => 'Invitation Accepted!',
      AddContactDeclined() => 'Invitation Declined',
      AddContactError() => 'Error',
      _ => '',
    };

    return Text(text, style: theme.h5);
  }

  Widget _buildSubtitle(FlickTheme theme) {
    final text = switch (state) {
      AddContactWaiting() => 'Waiting for response...',
      AddContactSuccess(:final username) => '$username accepted your invite!',
      AddContactDeclined() => 'Your invitation was declined',
      AddContactError(:final failure) => _getErrorMessage(failure),
      _ => '',
    };

    return Text(text, style: theme.body, textAlign: TextAlign.center);
  }

  String _getErrorMessage(Failure failure) {
    return switch (failure) {
      TorNotRunningError() => 'Tor is not running',
      TorConnectionError() => 'Could not connect to contact',
      RecipientOfflineError() => 'Contact is offline',
      MessageSendError() => 'Failed to send invitation',
      _ => 'An unexpected error occurred',
    };
  }

  Widget _buildActions(BuildContext context, FlickTheme theme) {
    return switch (state) {
      AddContactWaiting() => const SizedBox.shrink(),
      AddContactSuccess() => ElevatedButton(
        onPressed: onClose,
        child: const Text('Done'),
      ),
      AddContactDeclined() || AddContactError() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClose, child: const Text('Close')),
          const SizedBox(width: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
