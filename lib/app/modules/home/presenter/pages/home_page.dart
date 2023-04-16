import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wbc_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:wbc_challenge/app/modules/home/presenter/widgets/home_mount_warning.dart';
import 'package:wbc_challenge/app/modules/home/presenter/widgets/home_options_container.dart';
import 'package:wbc_challenge/app/modules/home/presenter/widgets/home_reserve_container.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:wbc_challenge/core/utils/widget_utils/build_base_stack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.getThemeColor(
            appColorTheme: AppColorEnum.backgroundBordeaux),
        title: Center(
          child: SizedBox(
            height: 45,
            child: Image.asset(
              'assets/launch_icon/WBC logo.jpeg',
            ),
          ),
        ),
      ),
      backgroundColor: context.getThemeColor(),
      body: _MountBody(
        controller: controller,
      ),
    );
  }
}

class _MountBody extends StatefulWidget {
  final HomeController controller;

  const _MountBody({
    super.key,
    required this.controller,
  });

  @override
  State<_MountBody> createState() => _MountBodyState();
}

class _MountBodyState extends State<_MountBody> {
  @override
  Widget build(BuildContext context) {
    return BuildBaseStack(
      basePageBody: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 12,
            ),
            child: MountHomeReserve(controller: widget.controller),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: HomeOptionsContainer(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: HomeMountWarning(),
          )
        ],
      ),
    );
  }
}

class MountHomeReserve extends StatelessWidget {
  final HomeController controller;

  const MountHomeReserve({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return HomeReserveContainer(
      onLeftRow: ValueListenableBuilder<int?>(
        valueListenable: controller.homeStore.availableReserves,
        builder: (_, availableReserves, widget) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.homeModalTitleAvailable,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: context.getThemeColor()),
                ),
                Text(
                  (availableReserves ?? 0).toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: context.getThemeColor(
                      appColorTheme: AppColorEnum.lightSand,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      onCenter: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          height: 50,
          width: 1,
          color: context.getThemeColor(
            appColorTheme: AppColorEnum.darkRed,
          ),
        ),
      ),
      onRightRow: ValueListenableBuilder<int?>(
        valueListenable: controller.homeStore.currentReserved,
        builder: (context, reservedPlaces, _) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!.homeModalTitleReserves,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: context.getThemeColor(),
                  ),
                ),
                Text(
                  (reservedPlaces ?? 0).toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: context.getThemeColor(
                      appColorTheme: AppColorEnum.lightSand,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
