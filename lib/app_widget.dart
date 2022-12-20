import 'package:flutter/material.dart';
import 'package:lop_app/core/themes/app_theme.dart';

import 'modules/homeview/homeview.dart';
import 'modules/practice_view/presentation/practice_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lop',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/practice': (context) => const PracticeView()
      },
    );
  }
}
