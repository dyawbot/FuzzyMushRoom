// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i6;
import 'package:mush_room/common/app_module.dart' as _i13;
import 'package:mush_room/feature/data/db/app_database.dart' as _i3;
import 'package:mush_room/feature/data/repo/implementation/login_repo_impl.dart'
    as _i10;
import 'package:mush_room/feature/data/repo/interface/login_repository.dart'
    as _i9;
import 'package:mush_room/feature/data/repo/source/local/login_dao.dart' as _i8;
import 'package:mush_room/feature/data/repo/source/remote/login_api.dart'
    as _i7;
import 'package:mush_room/feature/domain/usecases/login_usecase.dart' as _i11;
import 'package:mush_room/feature/gui/presenters/bloc/login_page_bloc.dart'
    as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.AppDatabase>(
      () => appModule.db,
      preResolve: true,
    );
    gh.lazySingleton<_i4.Client>(() => appModule.httpClient);
    gh.lazySingleton<_i5.Dio>(() => appModule.dio);
    gh.lazySingleton<_i6.InternetConnectionChecker>(
      () => appModule.internetConnectionChecker,
      instanceName: 'global',
    );
    gh.factory<_i7.LoginApi>(() => _i7.LoginApi.create(gh<_i5.Dio>()));
    gh.factory<_i8.LoginDao>(() => _i8.LoginDao.create(gh<_i3.AppDatabase>()));
    gh.factory<_i9.LoginRepository>(() => _i10.LoginRepoImpl(
          gh<_i7.LoginApi>(),
          gh<_i8.LoginDao>(),
          gh<_i6.InternetConnectionChecker>(instanceName: 'global'),
        ));
    gh.factory<_i11.LoginUsecase>(
        () => _i11.LoginUsecase(gh<_i9.LoginRepository>()));
    gh.factory<_i12.LoginPageBloc>(
        () => _i12.LoginPageBloc(gh<_i11.LoginUsecase>()));
    return this;
  }
}

class _$AppModule extends _i13.AppModule {}
