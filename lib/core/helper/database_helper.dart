import 'dart:io';
import 'dart:developer';

import 'package:catcher/core/catcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wbc_challenge/core/constants/app_constants_utils.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class DatabaseHelper {
  Database? database;

  List<ReserveEntity> _initialData = List.generate(
    4,
    (index) => ReserveEntity(
      id: index,
      dateReservation: DateTime.now().toString(),
      isPaid: false,
      isReserved: false,
      name: 'Churrasqueira $index',
      price: 0,
    ),
  );

  DatabaseHelper() {
    validateAndStartDatabase();
  }

  Future<void> validateAndStartDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath;
    try {
      if (Directory(path).existsSync() == false) {
        await Directory(path).create(recursive: true);
      }
      database = await openDatabase(
        '$path${'/' + AppConstantsUtils.databaseName}',
        version: 1,
        onCreate: (db, version) => _createDatabase(database: db),
      );
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> insertIntoDatabase({required ReserveEntity reserve}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    await database?.transaction((txn) async {
      int result = await txn.rawInsert(
        'INSERT INTO reservations(name, isPaid, isReserved, dateReservation, price) VALUES (?, ?, ?, ?, ?)',
        List.from(
          [
            reserve.name,
            reserve.isPaid,
            reserve.isReserved,
            reserve.dateReservation,
            reserve.price,
          ],
        ),
      );
      log('Database inserted $result');
    });
  }

  Future<int> countWhereIsNotReserved() async {
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM reservations WHERE isReserved = false',
    );
    return results.length;
  }

  Future<int> countWhereIsReserved() async {
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM reservations WHERE isReserved = true',
    );
    return results.length;
  }

  Future<List<Map<String, dynamic>>> getAllReservations() async {
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM reservations',
    );
    return results;
  }

  Future<bool> deleteReservation({required int idReservation}) async {
    int result = await database!.rawDelete(
        'DELETE FROM reservations WHERE id = $idReservation and isReserved = true');
    return result != 0;
  }

  Future<void> _createDatabase({required Database database}) async {
    database.execute(
      'CREATE TABLE reservations (id INTEGER PRIMARY KEY, name TEXT, isPaid BOOL, isReserved BOOL,dateReservation TEXT, price TEXT)',
    ).then((value) {
      _initialData.forEach((reserve) async {
        await insertIntoDatabase(reserve: reserve);
      });
    });
  }
}
