import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/article/domain/use_case/use_case.dart';
import 'package:news_test/core/handle_error/failure.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetDataUseCase getDataUseCase;

  bool isLastPage = false;
  int pageNumber = 0;
  final int numberOfArticlesPerRequest = 10;
  List<Article> articles = [];
  final int nextPageTrigger = 3;

  ArticleBloc(this.getDataUseCase) : super(ArticleInitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(ArticleLoadingState());
      try {
        final Either<Failure, List<Article>> result = await getDataUseCase(
          numberOfArticlesPerRequest: numberOfArticlesPerRequest,
          pageNumber: pageNumber,
        );
        result.fold((l) {
          print("error ArticleBloc --> ${l.message}");
          emit(ArticleErrorState());
        }, (postList) {
          isLastPage = postList.length < numberOfArticlesPerRequest;
          pageNumber = pageNumber + 1;
          articles.addAll(postList);
          emit(ArticleLoadedState());
        });
      } catch (e) {
        print("error --> $e");
        emit(ArticleErrorState());
      }
    });
    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      emit(ArticleLoadingState());
      if (event.index == articles.length - nextPageTrigger) {
        add(const LoadPageEvent());
      }
    });
  }
}
