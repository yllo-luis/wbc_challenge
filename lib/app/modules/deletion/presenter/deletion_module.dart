import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeletionModule extends Module {
  @override
  List<ModularRoute> get routes => List.from([
        ChildRoute(
          '/',
          child: (context, args) => Placeholder(),
        ),
      ]);

  @override
  List<Bind> get binds => List.from([

  ]);
}
