import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class EnableLocalAuthDialog extends StatefulWidget {
  final WhispTheme theme;
  final LocalAuthCubit localAuthCubit;

  const EnableLocalAuthDialog({
    super.key,
    required this.theme,
    required this.localAuthCubit,
  });

  @override
  State<EnableLocalAuthDialog> createState() => _EnableLocalAuthDialogState();
}

class _EnableLocalAuthDialogState extends State<EnableLocalAuthDialog> {
  bool _isLoading = false;
  bool _showPinSetup = false;
  bool _showPinConfirm = false;
  String? _pin;
  String? _errorMessage;
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleEnable() async {
    setState(() {
      _showPinSetup = true;
      _errorMessage = null;
    });
  }

  void _handlePinComplete(String pin) {
    if (!_showPinConfirm) {
      setState(() {
        _pin = pin;
        _showPinConfirm = true;
        _pinController.clear();
        _errorMessage = null;
      });
    } else {
      if (pin == _pin) {
        _proceedWithBiometric(pin);
      } else {
        setState(() {
          _errorMessage = 'PINs do not match. Please try again.';
          _showPinConfirm = false;
          _pin = null;
          _pinController.clear();
          _confirmPinController.clear();
        });
      }
    }
  }

  Future<void> _proceedWithBiometric(String pin) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await widget.localAuthCubit.enableLocalAuth(pin);
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      if (success) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = 'Biometric authentication failed. Please try again.';
          _showPinSetup = false;
          _showPinConfirm = false;
          _pin = null;
          _pinController.clear();
          _confirmPinController.clear();
        });
      }
    }
  }

  void _handleSkip() {
    Navigator.of(context).pop();
  }

  void _handleBack() {
    if (_showPinConfirm) {
      setState(() {
        _showPinConfirm = false;
        _pin = null;
        _confirmPinController.clear();
        _errorMessage = null;
      });
    } else {
      setState(() {
        _showPinSetup = false;
        _pinController.clear();
        _errorMessage = null;
      });
    }
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
      title: Text(
        _showPinSetup
            ? (_showPinConfirm ? 'Confirm PIN' : 'Set PIN')
            : 'Enable Biometric Lock?',
        style: widget.theme.h5,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: _showPinSetup
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _showPinConfirm
                        ? 'Re-enter your PIN to confirm'
                        : 'Create a 6-digit PIN to secure your account',
                    style: widget.theme.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Pinput(
                    length: 6,
                    controller: _showPinConfirm ? _confirmPinController : _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    errorPinTheme: errorPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    obscureText: true,
                    onCompleted: _handlePinComplete,
                    onChanged: (value) {
                      setState(() {
                        _errorMessage = null;
                      });
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
              )
            : Text(
                'Add an extra layer of security by requiring biometric authentication or PIN to access Whisp.',
                style: widget.theme.body,
              ),
      ),
      actions: [
        if (_showPinSetup) ...[
          if (_showPinConfirm)
            TextButton(
              onPressed: _isLoading ? null : _handleBack,
              child: Text(
                'Back',
                style: widget.theme.body.copyWith(
                  color: widget.theme.body.color?.withValues(alpha: 0.7),
                ),
              ),
            ),
          TextButton(
            onPressed: _isLoading ? null : () {
              setState(() {
                _showPinSetup = false;
                _showPinConfirm = false;
                _pin = null;
                _pinController.clear();
                _confirmPinController.clear();
                _errorMessage = null;
              });
            },
            child: Text(
              'Cancel',
              style: widget.theme.body.copyWith(
                color: widget.theme.body.color?.withValues(alpha: 0.7),
              ),
            ),
          ),
        ] else ...[
          TextButton(
            onPressed: _isLoading ? null : _handleSkip,
            child: Text(
              'Not Now',
              style: widget.theme.body.copyWith(
                color: widget.theme.body.color?.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: _isLoading ? null : _handleEnable,
            child: _isLoading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.theme.primary),
                    ),
                  )
                : Text(
                    'Enable',
                    style: widget.theme.body.copyWith(color: widget.theme.primary),
                  ),
          ),
        ],
      ],
    );
  }
}
