import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_test/article/data/model/article.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  const ArticleDetail({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.chevron_left, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitle(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Text(
        article.body,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
