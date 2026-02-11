import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:whisp/common/widgets/styled_button.dart';
import 'package:whisp/local_auth/application/cubit/local_auth_cubit.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class PinInputDialog extends StatefulWidget {
  final bool setNewPin;
  const PinInputDialog({super.key, this.setNewPin = false});

  static Future<String?> show(BuildContext context, bool setNewPin) async {
    return await showDialog<String>(
      context: context,
      builder: (context) => PinInputDialog(setNewPin: setNewPin),
    );
  }

  @override
  State<PinInputDialog> createState() => _PinputDialogState();
}

class _PinputDialogState extends State<PinInputDialog> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _pageController = PageController();
  final _confirmPinFocusNode = FocusNode();
  String? _firstPin;
  String? _errorMessage;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    _pageController.dispose();
    _confirmPinFocusNode.dispose();
    super.dispose();
  }

  void _onFirstPinCompleted(String pin) {
    _firstPin = pin;
    _pageController
        .nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
        .then((_) => _confirmPinFocusNode.requestFocus());
  }

  void _onConfirmPinCompleted(String pin) {
    if (pin == _firstPin) {
      Navigator.of(context).pop(pin);
    } else {
      setState(() {
        _errorMessage = 'PINs do not match';
        _confirmPinController.clear();
      });
    }
  }

  void _onEnterPinCompleted(BuildContext context, String pin) async {
    final result = await context.read<LocalAuthCubit>().authenticateWithPin(
      pin,
    );
    if (context.mounted && result) {
      context.pop(pin);
    }
  }

  void _goBack() {
    _confirmPinController.clear();
    setState(() => _errorMessage = null);
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.setNewPin) {
      return Dialog(
        backgroundColor: context.whispTheme.background,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: 220,
            width: 300,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPinPage(
                  title: 'Set new PIN',
                  controller: _pinController,
                  onCompleted: _onFirstPinCompleted,
                  onCancel: () => Navigator.of(context).pop(),
                ),
                _buildPinPage(
                  title: 'Confirm PIN',
                  controller: _confirmPinController,
                  onCompleted: _onConfirmPinCompleted,
                  errorMessage: _errorMessage,
                  onCancel: _goBack,
                  cancelText: 'Back',
                  focusNode: _confirmPinFocusNode,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildPinPage(
          title: 'Enter PIN',
          controller: _pinController,
          onCompleted: (pin) => _onEnterPinCompleted(context, pin),
          onCancel: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildPinPage({
    required String title,
    required TextEditingController controller,
    required void Function(String) onCompleted,
    required VoidCallback onCancel,
    String? errorMessage,
    String cancelText = 'Cancel',
    FocusNode? focusNode,
  }) {
    final theme = context.whispTheme;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: theme.primary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.stroke),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final errorPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: theme.error),
      decoration: BoxDecoration(
        border: Border.all(color: theme.error),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.h5),
        const SizedBox(height: 24),
        Pinput(
          length: 6,
          controller: controller,
          focusNode: focusNode,
          onCompleted: onCompleted,
          obscureText: true,
          defaultPinTheme: defaultPinTheme,
          errorPinTheme: errorPinTheme,
          forceErrorState: errorMessage != null,
          errorText: errorMessage,
          errorTextStyle: TextStyle(color: theme.error),
        ),
        const SizedBox(height: 24),
        StyledButton.secondary(text: cancelText, onPressed: onCancel),
      ],
    );
  }
}
