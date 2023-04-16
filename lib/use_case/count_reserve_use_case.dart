import 'package:wbc_challenge/core/helper/database_helper.dart';

class CountReserveUseCase {
  DatabaseHelper databaseHelper;

  CountReserveUseCase({required this.databaseHelper});

  Future<int> countReservedLocal() async {
    return await databaseHelper.countWhereIsReserved();
  }
}