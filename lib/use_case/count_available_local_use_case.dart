import 'package:wbc_challenge/core/helper/database_helper.dart';

class CountAvailableLocalUseCase {
  DatabaseHelper databaseHelper;

  CountAvailableLocalUseCase({required this.databaseHelper});

  Future<int> countAvailableLocal() async {
    return await databaseHelper.countWhereIsNotReserved();
  }
}