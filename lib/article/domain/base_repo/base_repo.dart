import 'package:dartz/dartz.dart';

import '../../../core/handle_error/failure.dart';
import '../../data/model/article.dart';

abstract class BaseRepo{
  Future<Either<Failure, List<Article>>> getData({required int pageNumber, required int numberOfArticlesPerRequest});
}