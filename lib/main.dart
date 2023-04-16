import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wbc_challenge/app/app_modular.dart';

import 'package:wbc_challenge/core/utils/widget_utils/error_widget.dart';
import 'package:wbc_challenge/core/constants/app_constants_utils.dart';

void main() {
  /// Parametros de observação em ambiente debug.
  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(
      enableDeviceParameters: false,
      enableCustomParameters: false,
      enableStackTrace: true,
      handleWhenRejected: true,
    ),
  ]);

  /// Parametros de observação em ambiente release.
  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
    DiscordHandler(
      AppConstantsUtils.discordWebhookUrl,
      enableDeviceParameters: true,
      enableStackTrace: true,
    )
  ]);

  /// Substituindo tela vermelha/cinza por widget customizado.
  ErrorWidget.builder = (details) => CustomErrorWidget(
        errorDetails: details,
      );

  Catcher(
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    enableLogger: true,
    runAppFunction: () => runApp(
      ModularApp(
        module: AppModule(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WBC_CHALLENGE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
