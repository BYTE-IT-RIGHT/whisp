import 'package:whisp/theme/domain/whisp_theme.dart';
import 'package:flutter/material.dart';

class PinInputWidget extends StatefulWidget {
  final int pinLength;
  final ValueChanged<String> onPinComplete;
  final String? errorMessage;
  final bool showError;

  const PinInputWidget({
    super.key,
    this.pinLength = 6,
    required this.onPinComplete,
    this.errorMessage,
    this.showError = false,
  });

  @override
  State<PinInputWidget> createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  String _pin = '';

  void _onNumberPressed(String number) {
    if (_pin.length < widget.pinLength) {
      setState(() {
        _pin += number;
      });

      if (_pin.length == widget.pinLength) {
        widget.onPinComplete(_pin);
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _clearPin() {
    setState(() {
      _pin = '';
    });
  }

  @override
  void didUpdateWidget(PinInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.showError != widget.showError && widget.showError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _clearPin();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.whispTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.pinLength,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < _pin.length
                      ? (widget.showError
                          ? Colors.red
                          : theme.primary)
                      : theme.stroke.withValues(alpha: 0.3),
                  border: Border.all(
                    color: index < _pin.length
                        ? Colors.transparent
                        : theme.stroke.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),

        if (widget.showError && widget.errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            widget.errorMessage!,
            style: theme.caption.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],

        const SizedBox(height: 48),

        Column(
          children: [
            for (int row = 0; row < 3; row++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int col = 1; col <= 3; col++)
                      _PinButton(
                        number: (row * 3 + col).toString(),
                        onPressed: () => _onNumberPressed(
                          (row * 3 + col).toString(),
                        ),
                        theme: theme,
                      ),
                  ],
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PinButton(
                  number: '0',
                  onPressed: () => _onNumberPressed('0'),
                  theme: theme,
                ),
                const SizedBox(width: 80),
                _PinButton(
                  icon: Icons.backspace_outlined,
                  onPressed: _onBackspace,
                  theme: theme,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PinButton extends StatelessWidget {
  final String? number;
  final IconData? icon;
  final VoidCallback onPressed;
  final WhispTheme theme;

  const _PinButton({
    this.number,
    this.icon,
    required this.onPressed,
    required this.theme,
  }) : assert(number != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 80,
      height: 80,
      child: Material(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: theme.stroke.withValues(alpha: 0.3),
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
                      size: 28,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

