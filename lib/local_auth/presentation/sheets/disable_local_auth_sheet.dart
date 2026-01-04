import 'package:flutter/material.dart';
import 'package:whisp/settings/application/cubit/settings_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class DisableLocalAuthSheet extends StatefulWidget {
  final WhispTheme theme;
  final SettingsCubit settingsCubit;
  final VoidCallback onVerified;

  const DisableLocalAuthSheet({
    super.key,
    required this.theme,
    required this.settingsCubit,
    required this.onVerified,
  });

  static Future<void> show({
    required BuildContext context,
    required WhispTheme theme,
    required SettingsCubit settingsCubit,
    required VoidCallback onVerified,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (sheetContext) => DisableLocalAuthSheet(
        theme: theme,
        settingsCubit: settingsCubit,
        onVerified: onVerified,
      ),
    );
  }

  @override
  State<DisableLocalAuthSheet> createState() => _DisableLocalAuthSheetState();
}

class _DisableLocalAuthSheetState extends State<DisableLocalAuthSheet> {
  String _pin = '';
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
          _showError = true;
          _errorMessage = 'Incorrect PIN. Please try again.';
          _pin = '';
        });
      }
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
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_open_outlined,
                  size: 32,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Disable Biometric Lock?',
                style: widget.theme.h5,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your PIN to disable biometric lock',
                style: widget.theme.body.copyWith(
                  color: widget.theme.body.color?.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _PinDots(
                pinLength: _pin.length,
                showError: _showError,
                theme: widget.theme,
              ),
              if (_showError && _errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  style: widget.theme.caption.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.theme.primary,
                    ),
                  ),
                )
              else
                _NumericKeypad(
                  onNumberPressed: _onNumberPressed,
                  onBackspace: _onBackspace,
                  theme: widget.theme,
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
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


