import 'package:wbc_challenge/core/helper/database_helper.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReserveLocalUseCase {
  DatabaseHelper databaseHelper;

  ReserveLocalUseCase({required this.databaseHelper});

  Future<void> reserveLocal({
    required ReserveEntity reserve,
  }) async {
    return await databaseHelper.updateDatabase(
      reserve: reserve,
    );
  }
}
