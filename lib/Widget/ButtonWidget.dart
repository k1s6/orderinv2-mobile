import 'package:flutter/material.dart';

class ButtonWithText extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Function onTap;

  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            onTap;
          },
          child: Icon(icon, color: color)),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
      ],
    );
  }
}