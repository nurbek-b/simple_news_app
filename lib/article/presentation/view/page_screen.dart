import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/article/presentation/bloc/article_bloc.dart';
import 'package:news_test/article/presentation/widgets/article_item.dart';
import 'package:news_test/article/presentation/widgets/error_dialog.dart';
import 'package:news_test/core/services/services_locator.dart';

class ArticlesOverviewScreen extends StatelessWidget {
  const ArticlesOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          appServiceLocator<ArticleBloc>()..add(const LoadPageEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
          centerTitle: true,
        ),
        body: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (context.read<ArticleBloc>().articles.isEmpty) {
              if (state == ArticleLoadingState()) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state == ArticleErrorState()) {
                return Center(
                  child: errorDialog(
                    size: 20,
                    onPressed: () {
                      context.read<ArticleBloc>().add(const LoadPageEvent());
                    },
                  ),
                );
              }
            }
            return ListView.builder(
              itemCount: context.read<ArticleBloc>().articles.length +
                  (context.read<ArticleBloc>().isLastPage ? 0 : 1),
              itemBuilder: (context, index) {
                // request more data when the user has reached the trigger point.
                context
                    .read<ArticleBloc>()
                    .add(CheckIfNeedMoreDataEvent(index: index));
                // when the user gets to the last item in the list, check whether
                // there is an error, otherwise, render a progress indicator.
                if (index == context.read<ArticleBloc>().articles.length) {
                  if (state == ArticleErrorState()) {
                    return Center(
                      child: errorDialog(
                        size: 15,
                        onPressed: () {
                          context
                              .read<ArticleBloc>()
                              .add(const LoadPageEvent());
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: CircularProgressIndicator(color: Colors.grey[200],),
                      ),
                    );
                  }
                }

                final Article article =
                    context.read<ArticleBloc>().articles[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      _onArticlePressed(context, article);
                    },
                    child: ArticleItem(article.title, article.body),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
