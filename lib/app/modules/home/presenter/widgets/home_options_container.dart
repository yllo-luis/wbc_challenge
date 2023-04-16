import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/enums/app_home_button_type_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeOptionsContainer extends StatefulWidget {
  const HomeOptionsContainer({Key? key}) : super(key: key);

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
            ),
          ),
        ),
      ),
    );
  }
}

class MountHomeButtons extends StatelessWidget {
  final AppHomeButtonTypeEnum appHomeButtonTypeEnum;

  const MountHomeButtons(
      {Key? key, this.appHomeButtonTypeEnum = AppHomeButtonTypeEnum.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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

  String getCorrectLabel({required BuildContext context}) {
    switch (appHomeButtonTypeEnum) {
      case AppHomeButtonTypeEnum.search:
        return AppLocalizations.of(context)!.homeModalOptionFind;
      case AppHomeButtonTypeEnum.reserve:
        return AppLocalizations.of(context)!.homeModalTitleReserves;
      case AppHomeButtonTypeEnum.delete:
        return AppLocalizations.of(context)!.homeModalOptionDelete;
    }
  }

  IconData getCorrectIcon() {
    switch (appHomeButtonTypeEnum) {
      case AppHomeButtonTypeEnum.search:
        return Icons.search;
      case AppHomeButtonTypeEnum.reserve:
        return Icons.book_online;
      case AppHomeButtonTypeEnum.delete:
        return Icons.delete;
    }
  }
}
