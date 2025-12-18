import 'package:whisp/add_contact/application/cubit/add_contact_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactForm extends StatefulWidget {
  const AddContactForm({super.key});

  @override
  State<AddContactForm> createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
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
                'Enter Contact Address',
                style: theme.subtitle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                'Paste their onion address to send an invite',
                style: theme.caption,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                focusNode: _focusNode,
                style: theme.body.copyWith(fontFamily: 'monospace', fontSize: 14),
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
                    borderSide: BorderSide(color: theme.stroke.withValues(alpha: 0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.stroke.withValues(alpha: 0.3)),
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
                  onPressed: _sendInvite,
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
                    'Send Invite',
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

  void _sendInvite() {
    if (_addressController.text.isNotEmpty) {
      context.read<AddContactCubit>().addContact(_addressController.text);
    }
  }
}

