import 'package:mush_room/feature/domain/entities/app_entity.dart';

abstract class AppDto<T extends AppEntity> {
  T toEntity();
}
