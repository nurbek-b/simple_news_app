part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

class LoadPageEvent extends ArticleEvent {
  const LoadPageEvent();
}

class CheckIfNeedMoreDataEvent extends ArticleEvent {
  final int index;
  const CheckIfNeedMoreDataEvent({required this.index});
}
