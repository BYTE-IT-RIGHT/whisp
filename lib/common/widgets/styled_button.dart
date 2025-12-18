import 'package:flick/common/widgets/styled_circular_progress_indicator.dart';
import 'package:flick/theme/domain/flick_theme.dart';
import 'package:flutter/material.dart';

enum _Type { primary, secondary }

class StyledButton extends StatelessWidget {
  final _Type _type;
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool disableElevation;
  final bool fullWidth;
  final Widget? trailing;
  final Widget? leading;
  final bool isLoading;

  const StyledButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.fullWidth = false,
    this.disableElevation = false,
    this.trailing,
    this.leading,
    this.isLoading = false,
  }) : _type = _Type.primary;

  const StyledButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.fullWidth = false,
    this.disableElevation = false,
    this.trailing,
    this.leading,
    this.isLoading = false,
  }) : _type = _Type.secondary;

  @override
  Widget build(BuildContext context) {
    final theme = context.flickTheme;

    late final Color bgColor;
    late final Color fgColor;
    Color? borderColor;

    switch (_type) {
      case _Type.primary:
        bgColor = backgroundColor ?? theme.primary;
        fgColor = foregroundColor ?? Colors.white;
        borderColor = null;
        break;
      case _Type.secondary:
        bgColor = backgroundColor ?? theme.secondary;
        fgColor = foregroundColor ?? theme.button.color ?? Colors.white;
        borderColor = theme.stroke;
        break;
    }

    final child = isLoading
        ? const StyledCircularProgressIndicator(size: 24)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 16)],
              Text(text, style: theme.button.copyWith(color: fgColor)),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: disableElevation ? 0 : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: borderColor != null
              ? BorderSide(color: borderColor)
              : BorderSide.none,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: fullWidth
          ? SizedBox(
              width: double.infinity,
              child: Center(child: child),
            )
          : child,
    );
  }
}
