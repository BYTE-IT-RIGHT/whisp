import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisp/common/widgets/styled_app_bar.dart';
import 'package:whisp/common/widgets/styled_scaffold.dart';
import 'package:whisp/di/injection.dart';
import 'package:whisp/mailbox/application/cubit/mailbox_cubit.dart';
import 'package:whisp/mailbox/presentation/widgets/mailbox_password_dialog.dart';
import 'package:whisp/mailbox/presentation/widgets/mailbox_scan_qr_card.dart';
import 'package:whisp/mailbox/presentation/widgets/mailbox_status_dialog.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

@RoutePage()
class AddMailboxScreen extends StatefulWidget {
  const AddMailboxScreen({super.key});

  @override
  State<AddMailboxScreen> createState() => _AddMailboxScreenState();
}

class _AddMailboxScreenState extends State<AddMailboxScreen> {
  final _addressController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _addressController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MailboxCubit>()..init(),
      child: BlocConsumer<MailboxCubit, MailboxState>(
        listenWhen: (previous, current) {
          return current is MailboxAddSuccess || current is MailboxAddError;
        },
        listener: (context, state) {
          if (state is MailboxAddSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Mailbox added successfully'),
                backgroundColor: context.whispTheme.contrast,
              ),
            );
          } else if (state is MailboxAddError) {
            MailboxStatusDialog.show(context, state);
          }
        },
        builder: (context, state) {
          return StyledScaffold(
            appBar: StyledAppBar(title: 'Add Mailbox'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildAddressForm(context),
                  const SizedBox(height: 24),
                  MailboxScanQrCard(
                    onScanned: (address) => _onAddressEntered(context, address),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressForm(BuildContext context) {
    final theme = context.whispTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'ADD BY ADDRESS',
            style: theme.overline.copyWith(
              color: theme.caption.color,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.secondary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.stroke.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Mailbox Address',
                style: theme.subtitle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                'Paste the onion address of your mailbox',
                style: theme.caption,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                focusNode: _focusNode,
                style: theme.body.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'xxxxxxxx.onion',
                  hintStyle: theme.body.copyWith(
                    color: theme.caption.color,
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: theme.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.stroke.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.stroke.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.primary, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.content_paste_rounded,
                      color: theme.caption.color,
                    ),
                    onPressed: _pasteFromClipboard,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      _onAddressEntered(context, _addressController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: theme.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData('text/plain');
    if (data?.text != null) {
      _addressController.text = data!.text!;
    }
  }

  Future<void> _onAddressEntered(BuildContext context, String address) async {
    if (address.isEmpty) return;

    final pin = await MailboxPasswordDialog.show(context);
    if (pin == null || !context.mounted) return;

    context.read<MailboxCubit>().addMailbox(onionAddress: address, pin: pin);
  }
}
