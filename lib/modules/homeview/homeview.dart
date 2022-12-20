import 'package:flutter/material.dart';
import 'package:lop_app/core/components/app_elevated_button.dart';
import 'package:lop_app/core/themes/app_colors.dart';

import 'presentation/components/app_top_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, 48), child: const AppTopBar()),
      body: SafeArea(
        child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                    top: 24,
                    right: 24,
                    left: 24,
                    child: AppElevatedButton(
                      width: 320,
                      label: "Test 1",
                      buttonColor: AppColors.primaryColor,
                    )),
                Positioned(
                    top: 88,
                    right: 24,
                    left: 24,
                    child: AppElevatedButton(
                      width: 320,
                      label: "Test 2",
                      buttonColor: AppColors.primaryColor,
                      onTap: () => Navigator.pushNamed(context, '/practice'),
                    )),
                Positioned(
                    top: 152,
                    right: 24,
                    left: 24,
                    child: AppElevatedButton(
                      width: 320,
                      label: "Test 3",
                      buttonColor: AppColors.primaryColor,
                      onTap: () => Navigator.pushNamed(context, '/practice'),
                    )),
              ],
            )),
      ),
    );
  }
}
