part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArticleInitialState extends ArticleState {
   ArticleInitialState();
}

class ArticleLoadedState extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleErrorState extends ArticleState {}