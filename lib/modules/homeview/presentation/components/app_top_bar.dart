import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_colors.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2))
      ]),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 2,
              bottom: 0,
              left: 24,
              child: Text(
                "LoP",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
