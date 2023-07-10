import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color color;
  final ButtonStyle? styleButton;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.color = Colors.blue,
    this.styleButton,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox.expand(
            child: ElevatedButton(
              onPressed: onPressed,
              onLongPress: onLongPress,
              style: styleButton,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
