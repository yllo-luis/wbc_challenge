import 'dart:async';

import 'package:wbc_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:wbc_challenge/use_case/count_available_local_use_case.dart';
import 'package:wbc_challenge/use_case/count_reserve_use_case.dart';

class HomeController {
  final CountAvailableLocalUseCase countAvailableLocalUseCase;
  final CountReserveUseCase countReserveUseCase;
  final HomeStore homeStore;

  HomeController({
    required this.countAvailableLocalUseCase,
    required this.countReserveUseCase,
    required this.homeStore,
  }) {
    init();
  }

  void init() async {
    await Future.delayed(Duration(
      seconds: 2,
    ), () {
      getCurrentAvailable();
      getCurrentReserved();
    });
  }

  Future<void> getCurrentAvailable() async {
    homeStore.availableReserves.value = await countAvailableLocalUseCase.countAvailableLocal();
  }

  Future<void> getCurrentReserved() async {
    homeStore.currentReserved.value = await countReserveUseCase.countReservedLocal();
  }

  void dispose() {}
}
