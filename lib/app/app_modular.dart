import 'package:flutter_modular/flutter_modular.dart';
import 'package:wbc_challenge/app/modules/home/presenter/home_module.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/reserve_module.dart';
import 'package:wbc_challenge/core/helper/database_helper.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => List.from(
        [
          Bind.singleton<DatabaseHelper>(
            (i) => DatabaseHelper(),
          ),
        ],
      );

  @override
  List<ModularRoute> get routes => List.from(
        [
          ModuleRoute(
            Modular.initialRoute,
            module: HomeModule(),
          ),
          ModuleRoute(
            '/reserve',
            module: ReserveModule(),
          ),
        ],
      );
}
