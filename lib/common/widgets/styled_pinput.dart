import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:whisp/theme/domain/whisp_theme.dart';

class StyledPinput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String) onCompleted;
  final bool obscureText;
  final int length;
  final String? errorMessage;

  const StyledPinput({
    super.key,
    required this.controller,
    required this.onCompleted,
    this.focusNode,
    this.obscureText = true,
    this.length = 6,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
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
    
    final focusedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: theme.primary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.primary, width: 2),
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
    
    return Pinput(
      length: length,
      controller: controller,
      focusNode: focusNode,
      onCompleted: onCompleted,
      obscureText: obscureText,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      errorPinTheme: errorPinTheme,
      forceErrorState: errorMessage != null,
      errorText: errorMessage,
      errorTextStyle: TextStyle(color: theme.error),
    );
  }
}


