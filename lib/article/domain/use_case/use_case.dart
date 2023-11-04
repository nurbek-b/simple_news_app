import 'package:dartz/dartz.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/article/domain/base_repo/base_repo.dart';
import 'package:news_test/core/handle_error/failure.dart';


class GetDataUseCase {
  final BaseRepo baseRepo;

  GetDataUseCase({required this.baseRepo});

  Future<Either<Failure, List<Article>>> call(
      {required int pageNumber, required int numberOfArticlesPerRequest}) async {
    return await baseRepo.getData(
        numberOfArticlesPerRequest: numberOfArticlesPerRequest,
        pageNumber: pageNumber);
  }
}
