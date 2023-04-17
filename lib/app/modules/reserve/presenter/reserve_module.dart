import 'package:flutter_modular/flutter_modular.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/controller/reserve_controller.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/pages/reserve_page.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/store/reserve_store.dart';
import 'package:wbc_challenge/use_case/get_all_reservations_use_case.dart';
import 'package:wbc_challenge/use_case/reserve_local_use_case.dart';

class ReserveModule extends Module {
  @override
  List<ModularRoute> get routes => List.from([
        ChildRoute(
          '/',
          child: (context, args) => ReservePage(),
        ),
      ]);

  @override
  List<Bind> get binds => List.from(
        [
          Bind.lazySingleton<ReserveStore>(
            (i) => ReserveStore(),
          ),
          Bind.lazySingleton<ReserveLocalUseCase>(
            (i) => ReserveLocalUseCase(
              databaseHelper: i(),
            ),
          ),
          Bind.lazySingleton<GetAllReservationsUseCase>(
            (i) => GetAllReservationsUseCase(
              databaseHelper: i(),
            ),
          ),
          Bind.lazySingleton<ReserveController>(
            (i) => ReserveController(
              reserveLocalUseCase: i(),
              getAllReservationsUseCase: i(),
              reserveStore: i(),
            ),
          )
        ],
      );
}
