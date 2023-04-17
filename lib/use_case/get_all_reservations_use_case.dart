import 'package:wbc_challenge/core/helper/database_helper.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class GetAllReservationsUseCase {
  DatabaseHelper databaseHelper;

  GetAllReservationsUseCase({required this.databaseHelper});

  Future<List<ReserveEntity>> countReservedLocal() async {
     final List<Map<String, dynamic>> results = await databaseHelper.getAllReservations();
     final List<ReserveEntity> allReserves = List.empty(growable: true);

     results.forEach((element) {
       allReserves.add(ReserveEntity.fromJson(element));
     });
     return allReserves;
  }
}