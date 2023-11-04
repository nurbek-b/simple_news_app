import 'package:dartz/dartz.dart';
import 'package:news_test/article/data/data_source/remote_data_source.dart';
import 'package:news_test/article/data/model/article.dart';
import 'package:news_test/article/domain/base_repo/base_repo.dart';
import 'package:news_test/core/handle_error/execptions.dart';
import 'package:news_test/core/handle_error/failure.dart';
import 'package:news_test/core/handle_error/network_info.dart';

class Repo extends BaseRepo {
  final RemoteData remoteData;
  final NetworkInfo networkInfo;

  Repo({required this.remoteData,required this.networkInfo});

  @override
  Future<Either<Failure, List<Article>>> getData(
      {required int pageNumber, required int numberOfArticlesPerRequest}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.getData(
            numberOfArticlesPerRequest: numberOfArticlesPerRequest,
            pageNumber: pageNumber);
        return Right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.message.toString()));
      }
    } else {
      return left(const ServerFailure(message: 'No Internet Connection'));
    }
  }
}
