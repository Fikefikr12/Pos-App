import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReusableButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget? trailing;
  final double? width;
  final VoidCallback? onPressed;

  const ReusableButton({
    super.key,
    required this.label,
    this.icon,
    this.trailing,
    this.width,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;

    return ShadButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: ResponsiveBreakpoints.of(context).isTablet ? 9 : 11,
        ),
      ),
      leading: Icon(icon),
      backgroundColor: theme.primary,
      foregroundColor: theme.primaryForeground,
      hoverBackgroundColor: theme.secondary,
      trailing: trailing,
      onPressed: onPressed ?? () {},
      width: width,
    );
  }
}
