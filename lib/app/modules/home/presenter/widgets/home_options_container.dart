import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/enums/app_home_button_type_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeOptionsContainer extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState> refreshKey;

  const HomeOptionsContainer({required this.refreshKey});

  @override
  State<HomeOptionsContainer> createState() => _HomeOptionsContainerState();
}

class _HomeOptionsContainerState extends State<HomeOptionsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: context.getThemeColor().withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          AppHomeButtonTypeEnum.values.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MountHomeButtons(
              appHomeButtonTypeEnum: AppHomeButtonTypeEnum.values[index],
              refreshKey: AppHomeButtonTypeEnum.values[index] == AppHomeButtonTypeEnum.update ? widget.refreshKey : null,
            ),
          ),
        ),
      ),
    );
  }
}

class MountHomeButtons extends StatelessWidget {
  final AppHomeButtonTypeEnum appHomeButtonTypeEnum;
  final GlobalKey<RefreshIndicatorState>? refreshKey;

  const MountHomeButtons({
    Key? key,
    this.appHomeButtonTypeEnum = AppHomeButtonTypeEnum.search,
    this.refreshKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToCorrectModule(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: context.getThemeColor(
                  appColorTheme: AppColorEnum.backgroundBordeaux),
              shape: BoxShape.circle,
            ),
            child: Icon(
              getCorrectIcon(),
              color: context.getThemeColor(
                appColorTheme: AppColorEnum.lightSand,
              ),
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              getCorrectLabel(context: context),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateToCorrectModule(BuildContext context) {
    switch (appHomeButtonTypeEnum) {
      case AppHomeButtonTypeEnum.search:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: context.getThemeColor(
              appColorTheme: AppColorEnum.backgroundBordeaux,
            ),
            content: Text(
              AppLocalizations.of(context)!.appFutureFeature,
              style: GoogleFonts.poppins(),
            ),
          ),
        );
        break;
      case AppHomeButtonTypeEnum.reserve:
        Modular.to.pushNamed('/reserve/');
        break;
      case AppHomeButtonTypeEnum.update:
        refreshKey?.currentState?.show();
        break;
    }
  }

  String getCorrectLabel({required BuildContext context}) {
    switch (appHomeButtonTypeEnum) {
      case AppHomeButtonTypeEnum.search:
        return AppLocalizations.of(context)!.homeModalOptionFind;
      case AppHomeButtonTypeEnum.reserve:
        return AppLocalizations.of(context)!.homeModalOptionReserve;
      case AppHomeButtonTypeEnum.update:
        return AppLocalizations.of(context)!.homeModalOptionUpdate;
    }
  }

  IconData getCorrectIcon() {
    switch (appHomeButtonTypeEnum) {
      case AppHomeButtonTypeEnum.search:
        return Icons.search;
      case AppHomeButtonTypeEnum.reserve:
        return Icons.book_online;
      case AppHomeButtonTypeEnum.update:
        return Icons.update;
    }
  }
}
