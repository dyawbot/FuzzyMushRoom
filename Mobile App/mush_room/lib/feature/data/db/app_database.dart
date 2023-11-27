import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:mush_room/feature/domain/entities/login_entity.dart';

import '../repo/source/local/login_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [
  LoginEntity,
])
abstract class AppDatabase extends FloorDatabase {
  LoginDao get loginDAO;
  static Future<AppDatabase> create() async =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
