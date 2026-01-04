import 'package:flutter/material.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

enum _SetupStep { intro, enterPin, confirmPin }

class EnableLocalAuthSheet extends StatefulWidget {
  final WhispTheme theme;
  final LocalAuthCubit localAuthCubit;

  const EnableLocalAuthSheet({
    super.key,
    required this.theme,
    required this.localAuthCubit,
  });

  static Future<bool?> show({
    required BuildContext context,
    required WhispTheme theme,
    required LocalAuthCubit localAuthCubit,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (sheetContext) => EnableLocalAuthSheet(
        theme: theme,
        localAuthCubit: localAuthCubit,
      ),
    );
  }

  @override
  State<EnableLocalAuthSheet> createState() => _EnableLocalAuthSheetState();
}

class _EnableLocalAuthSheetState extends State<EnableLocalAuthSheet> {
  _SetupStep _step = _SetupStep.intro;
  String _pin = '';
  String? _firstPin;
  bool _isLoading = false;
  bool _showError = false;
  String? _errorMessage;

  void _onNumberPressed(String number) {
    if (_pin.length < 6 && !_isLoading) {
      setState(() {
        _pin += number;
        _showError = false;
        _errorMessage = null;
      });

      if (_pin.length == 6) {
        _handlePinComplete(_pin);
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty && !_isLoading) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _showError = false;
        _errorMessage = null;
      });
    }
  }

  void _handlePinComplete(String pin) {
    if (_step == _SetupStep.enterPin) {
      setState(() {
        _firstPin = pin;
        _pin = '';
        _step = _SetupStep.confirmPin;
      });
    } else if (_step == _SetupStep.confirmPin) {
      if (pin == _firstPin) {
        _proceedWithBiometric(pin);
      } else {
        setState(() {
          _showError = true;
          _errorMessage = 'PINs do not match. Please try again.';
          _pin = '';
          _firstPin = null;
          _step = _SetupStep.enterPin;
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
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _showError = true;
          _errorMessage = 'Biometric authentication failed. Please try again.';
          _step = _SetupStep.intro;
          _pin = '';
          _firstPin = null;
        });
      }
    }
  }

  void _handleBack() {
    if (_step == _SetupStep.confirmPin) {
      setState(() {
        _step = _SetupStep.enterPin;
        _pin = '';
        _firstPin = null;
        _errorMessage = null;
        _showError = false;
      });
    } else if (_step == _SetupStep.enterPin) {
      setState(() {
        _step = _SetupStep.intro;
        _pin = '';
        _errorMessage = null;
        _showError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: widget.theme.stroke.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              if (_step == _SetupStep.intro)
                _IntroContent(
                  theme: widget.theme,
                  isLoading: _isLoading,
                  onEnable: () {
                    setState(() {
                      _step = _SetupStep.enterPin;
                    });
                  },
                  onCancel: () => Navigator.of(context).pop(false),
                )
              else
                _PinSetupContent(
                  theme: widget.theme,
                  step: _step,
                  pinLength: _pin.length,
                  showError: _showError,
                  errorMessage: _errorMessage,
                  isLoading: _isLoading,
                  onNumberPressed: _onNumberPressed,
                  onBackspace: _onBackspace,
                  onBack: _handleBack,
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroContent extends StatelessWidget {
  final WhispTheme theme;
  final bool isLoading;
  final VoidCallback onEnable;
  final VoidCallback onCancel;

  const _IntroContent({
    required this.theme,
    required this.isLoading,
    required this.onEnable,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fingerprint_rounded,
            size: 40,
            color: theme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Enable Biometric Lock?',
          style: theme.h5,
        ),
        const SizedBox(height: 12),
        Text(
          'Add an extra layer of security by requiring biometric authentication or PIN to access Whisp.',
          style: theme.body.copyWith(
            color: theme.body.color?.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : onEnable,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Enable',
              style: theme.button.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: isLoading ? null : onCancel,
          child: Text(
            'Not Now',
            style: theme.body.copyWith(
              color: theme.body.color?.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _PinSetupContent extends StatelessWidget {
  final WhispTheme theme;
  final _SetupStep step;
  final int pinLength;
  final bool showError;
  final String? errorMessage;
  final bool isLoading;
  final ValueChanged<String> onNumberPressed;
  final VoidCallback onBackspace;
  final VoidCallback onBack;

  const _PinSetupContent({
    required this.theme,
    required this.step,
    required this.pinLength,
    required this.showError,
    required this.errorMessage,
    required this.isLoading,
    required this.onNumberPressed,
    required this.onBackspace,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isConfirmStep = step == _SetupStep.confirmPin;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: isLoading ? null : onBack,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: theme.body.color,
              ),
            ),
            Expanded(
              child: Text(
                isConfirmStep ? 'Confirm PIN' : 'Set PIN',
                style: theme.h5,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isConfirmStep
              ? 'Re-enter your PIN to confirm'
              : 'Create a 6-digit PIN to secure your account',
          style: theme.body.copyWith(
            color: theme.body.color?.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _PinDots(
          pinLength: pinLength,
          showError: showError,
          theme: theme,
        ),
        if (showError && errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            errorMessage!,
            style: theme.caption.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 32),
        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
            ),
          )
        else
          _NumericKeypad(
            onNumberPressed: onNumberPressed,
            onBackspace: onBackspace,
            theme: theme,
          ),
      ],
    );
  }
}

class _PinDots extends StatelessWidget {
  final int pinLength;
  final bool showError;
  final WhispTheme theme;

  const _PinDots({
    required this.pinLength,
    required this.showError,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < pinLength
                  ? (showError ? Colors.red : theme.primary)
                  : theme.stroke.withValues(alpha: 0.3),
              border: Border.all(
                color: index < pinLength
                    ? Colors.transparent
                    : theme.stroke.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onNumberPressed;
  final VoidCallback onBackspace;
  final WhispTheme theme;

  const _NumericKeypad({
    required this.onNumberPressed,
    required this.onBackspace,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int row = 0; row < 3; row++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 1; col <= 3; col++)
                  _KeypadButton(
                    number: (row * 3 + col).toString(),
                    onPressed: () => onNumberPressed((row * 3 + col).toString()),
                    theme: theme,
                  ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 72),
            _KeypadButton(
              number: '0',
              onPressed: () => onNumberPressed('0'),
              theme: theme,
            ),
            _KeypadButton(
              icon: Icons.backspace_outlined,
              onPressed: onBackspace,
              theme: theme,
            ),
          ],
        ),
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String? number;
  final IconData? icon;
  final VoidCallback onPressed;
  final WhispTheme theme;

  const _KeypadButton({
    this.number,
    this.icon,
    required this.onPressed,
    required this.theme,
  }) : assert(number != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 72,
      height: 72,
      child: Material(
        color: theme.background,
        borderRadius: BorderRadius.circular(36),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(36),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: theme.stroke.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: number != null
                  ? Text(
                      number!,
                      style: theme.h4.copyWith(
                        color: theme.body.color,
                      ),
                    )
                  : Icon(
                      icon,
                      color: theme.body.color,
                      size: 24,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}


