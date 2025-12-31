import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:whisp/settings/application/cubit/settings_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class DisableLocalAuthDialog extends StatefulWidget {
  final WhispTheme theme;
  final SettingsCubit settingsCubit;
  final VoidCallback onVerified;

  const DisableLocalAuthDialog({
    super.key,
    required this.theme,
    required this.settingsCubit,
    required this.onVerified,
  });

  @override
  State<DisableLocalAuthDialog> createState() => _DisableLocalAuthDialogState();
}

class _DisableLocalAuthDialogState extends State<DisableLocalAuthDialog> {
  bool _isLoading = false;
  String? _errorMessage;
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handlePinComplete(String pin) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await widget.settingsCubit.disableLocalAuthWithPin(pin);
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      if (success) {
        widget.onVerified();
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = 'Incorrect PIN. Please try again.';
          _pinController.clear();
        });
      }
    }
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: widget.theme.h4,
      decoration: BoxDecoration(
        color: widget.theme.background,
        border: Border.all(color: widget.theme.stroke.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: widget.theme.primary, width: 2),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red),
    );

    return AlertDialog(
      backgroundColor: widget.theme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: widget.theme.stroke),
      ),
      title: Text('Disable Biometric Lock?', style: widget.theme.h5),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your PIN to disable biometric lock',
              style: widget.theme.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Pinput(
              length: 6,
              controller: _pinController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              errorPinTheme: _errorMessage != null ? errorPinTheme : null,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              obscureText: true,
              enabled: !_isLoading,
              onCompleted: _handlePinComplete,
              onChanged: (value) {
                if (_errorMessage != null) {
                  setState(() {
                    _errorMessage = null;
                  });
                }
              },
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: widget.theme.caption.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _handleCancel,
          child: Text(
            'Cancel',
            style: widget.theme.body.copyWith(
              color: widget.theme.body.color?.withValues(alpha: 0.7),
            ),
          ),
        ),
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(widget.theme.primary),
              ),
            ),
          ),
      ],
    );
  }
}

