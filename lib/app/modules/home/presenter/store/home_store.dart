import 'package:flutter/material.dart';

class HomeStore {
  ValueNotifier<int?> availableReserves = ValueNotifier(null);
  ValueNotifier<int?> currentReserved = ValueNotifier(null);
}