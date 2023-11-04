import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_test/article/data/data_source/remote_data_source.dart';
import 'package:news_test/article/data/repo/repo.dart';
import 'package:news_test/article/domain/base_repo/base_repo.dart';
import 'package:news_test/article/domain/use_case/use_case.dart';
import 'package:news_test/article/presentation/bloc/article_bloc.dart';
import 'package:news_test/core/handle_error/network_info.dart';


final GetIt appServiceLocator = GetIt.instance;

class AppServiceLocator {
  static Future<void> initAppServiceLocator() async {
    appServiceLocator.registerFactory<ArticleBloc>(
        () => ArticleBloc(appServiceLocator()));

    appServiceLocator.registerLazySingleton<GetDataUseCase>(
        () => GetDataUseCase(baseRepo: appServiceLocator()));

    appServiceLocator.registerLazySingleton<BaseRepo>(() => Repo(
        networkInfo: appServiceLocator(), remoteData: appServiceLocator()));

    appServiceLocator.registerLazySingleton<RemoteData>(() => RemoteDataImpl());

    // Network information
    appServiceLocator.registerLazySingleton(() => InternetConnectionChecker());
    appServiceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(appServiceLocator()));
  }
}
