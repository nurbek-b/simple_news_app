import 'package:flutter/material.dart';
import 'package:news_test/article/presentation/view/page_screen.dart';
import 'package:news_test/config/routes/routes.dart';
import 'package:news_test/config/theme/app_theme.dart';

import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServiceLocator.initAppServiceLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const ArticlesOverviewScreen(),
    );
  }
}
