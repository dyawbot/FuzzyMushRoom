import 'package:floor/floor.dart';
import 'package:mush_room/feature/domain/entities/app_entity.dart';

abstract class AppDao<T extends AppEntity> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(T apps);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<T> data);
}
