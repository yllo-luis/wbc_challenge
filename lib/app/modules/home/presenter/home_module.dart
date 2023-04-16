import 'package:flutter_modular/flutter_modular.dart';
import 'package:wbc_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:wbc_challenge/app/modules/home/presenter/pages/home_page.dart';
import 'package:wbc_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:wbc_challenge/core/helper/database_helper.dart';
import 'package:wbc_challenge/use_case/count_available_local_use_case.dart';
import 'package:wbc_challenge/use_case/count_reserve_use_case.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => List.from([
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => HomePage(),
        ),
      ]);

  @override
  List<Bind> get binds => List.from(
        [
          Bind.lazySingleton(
            (i) => CountAvailableLocalUseCase(
              databaseHelper: i.get<DatabaseHelper>(),
            ),
          ),
          Bind.lazySingleton(
            (i) => CountReserveUseCase(
              databaseHelper: i.get<DatabaseHelper>(),
            ),
          ),
          Bind.lazySingleton(
            (i) => HomeStore(),
          ),
          Bind.lazySingleton(
            (i) => HomeController(
              countAvailableLocalUseCase: i.get<CountAvailableLocalUseCase>(),
              countReserveUseCase: i.get<CountReserveUseCase>(),
              homeStore: i.get<HomeStore>(),
            ),
          )
        ],
      );
}
