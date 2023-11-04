import 'package:flutter/material.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/article/presentation/view/page_screen.dart';
import 'package:news_test/article/presentation/widgets/article_detail.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const ArticlesOverviewScreen());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetail(article: settings.arguments as Article));

      default:
        return _materialRoute(const ArticlesOverviewScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
