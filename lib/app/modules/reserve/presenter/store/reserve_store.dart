import 'package:flutter/material.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReserveStore {
  ValueNotifier<List<ReserveEntity>> reserves = ValueNotifier(
    List.empty(),
  );

  ValueNotifier<bool> isLoading = ValueNotifier(true);

  ValueNotifier<bool> isReserved = ValueNotifier(false);

  ValueNotifier<DateTime> reservedDate = ValueNotifier(DateTime.now());
}
