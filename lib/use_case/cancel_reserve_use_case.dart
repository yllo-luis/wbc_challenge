import 'package:wbc_challenge/core/helper/database_helper.dart';

class CancelReserveUseCase {
  DatabaseHelper databaseHelper;

  CancelReserveUseCase({required this.databaseHelper});

  Future<bool> cancelReservation({required int idReservation}) async {
    return await databaseHelper.deleteReservation(idReservation: idReservation);
  }
}