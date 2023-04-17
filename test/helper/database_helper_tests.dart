import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wbc_challenge/core/helper/database_helper.dart';

void main() {
  group('Database Helper class unit tests', () {
    late DatabaseHelper databaseHelper;

    setUp(() {
      sqfliteFfiInit();

      // Utilizando factoty ffi para testes.
      databaseFactory = databaseFactoryFfi;

      databaseHelper = DatabaseHelper();
    });

    test(
      'Ao iniciar o banco dados devem ser populados assim que possível',
      () async {
        Future.delayed(
          const Duration(seconds: 1),
          () async {
            List<Map<String, dynamic>> results =
                await databaseHelper.getAllReservations();
            expect(
              results.length,
              isNot(0),
            );
          },
        );
      },
    );

    test('Ao consultar reservas todas devem estar disponíveis', () {
      Future.delayed(
        const Duration(seconds: 1),
        () async {
          int result = await databaseHelper.countWhereIsNotReserved();
          expect(
            result,
            isNot(0),
          );
        },
      );
    });

    test('Ao consultar objetos reservados o resultado deve ser zero', () {
      Future.delayed(
        const Duration(seconds: 1),
            () async {
          int result = await databaseHelper.countWhereIsReserved();
          expect(
            result,
            0,
          );
        },
      );
    });
  });
}
