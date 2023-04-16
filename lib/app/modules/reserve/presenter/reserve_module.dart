import 'package:flutter_modular/flutter_modular.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/pages/reserve_page.dart';

class ReserveModule extends Module {
  @override
  List<ModularRoute> get routes => List.from([
        ChildRoute(
          '/',
          child: (context, args) => ReservePage(),
        ),
      ]);

  @override
  List<Bind> get binds => List.from([]);
}
