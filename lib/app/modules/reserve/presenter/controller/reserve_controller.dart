import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/store/reserve_store.dart';
import 'package:wbc_challenge/core/constants/app_constants_utils.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';
import 'package:wbc_challenge/use_case/get_all_reservations_use_case.dart';
import 'package:wbc_challenge/use_case/reserve_local_use_case.dart';

class ReserveController {
  final ReserveStore reserveStore;
  final ReserveLocalUseCase reserveLocalUseCase;
  final GetAllReservationsUseCase getAllReservationsUseCase;

  ReserveController({
    required this.reserveStore,
    required this.reserveLocalUseCase,
    required this.getAllReservationsUseCase,
  }) {
    init();
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> init() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        getAllReservationsUseCase.countReservedLocal().then((reservations) {
          reserveStore.reserves.value = reservations;
          reserveStore.isLoading.value = false;
        });
      },
    );
  }

  Future<void> reserveObject({required ReserveEntity reserve, bool confirmReserve = true}) async {
    await reserveLocalUseCase
        .reserveLocal(
      reserve: ReserveEntity(
        id: reserve.id,
        name: reserve.name ?? AppConstantsUtils.emptyString,
        isPaid: confirmReserve,
        isReserved: confirmReserve,
        dateReservation: confirmReserve ? reserveStore.reservedDate.value : DateTime.now(),
        price: 0,
      ),
    )
        .whenComplete(
      () {
        if (confirmReserve) {
          reserveStore.isReserved.value = true;
        }
        init();
      },
    );
  }

  void disposeDialogData() {
    dateController.clear();
    priceController.clear();
    reserveStore.reservedDate.value = DateTime.now();
    reserveStore.isReserved.value = false;
  }
}
