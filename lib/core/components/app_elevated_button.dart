import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.label,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.white,
    this.labelColor = Colors.white,
    this.onTap,
    this.width = 120,
    this.height = 40,
  }) : super(key: key);
  final double width;
  final double height;

  final String label;
  final Color buttonColor;
  final Color borderColor;
  final Color labelColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: labelColor,
            ),
          ),
        ),
      ),
    );
  }
}
