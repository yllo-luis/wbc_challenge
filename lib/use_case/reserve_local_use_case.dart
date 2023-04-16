import 'package:wbc_challenge/core/helper/database_helper.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReserveLocalUseCase {
  DatabaseHelper databaseHelper;

  ReserveLocalUseCase({required this.databaseHelper});

  Future<void> reserveLocal({
    required String name,
    required bool isPaid,
    required bool isReserved,
    required String dateReservation,
    required int price,
  }) async {
    return await databaseHelper.insertIntoDatabase(
      reserve: ReserveEntity(
        name: name,
        isPaid: isPaid,
        price: price,
        isReserved: isReserved,
        dateReservation: dateReservation,
      ),
    );
  }
}
