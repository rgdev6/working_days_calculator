import "package:flutter/material.dart";

class IncrementDateButton extends StatelessWidget {
  const IncrementDateButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon});

  factory IncrementDateButton.plus({required VoidCallback? onPressed}) =>
      IncrementDateButton(
          onPressed: onPressed,
          label: const Icon(
            Icons.exposure_plus_1,
          ),
          icon: const Icon(
            Icons.calendar_today,
          ));

  factory IncrementDateButton.minus({required VoidCallback? onPressed}) =>
      IncrementDateButton(
          onPressed: onPressed,
          label: const Icon(
            Icons.exposure_minus_1,
          ),
          icon: const Icon(
            Icons.calendar_today,
          ));

  final VoidCallback? onPressed;
  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: label,
      icon: icon,
    );
  }
}
