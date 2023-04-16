import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeMountWarning extends StatelessWidget {
  const HomeMountWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.getThemeColor(
          appColorTheme: AppColorEnum.backgroundBordeaux,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 75,
            child: Lottie.asset(
              'assets/lottie_animations/warning.json',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.homeModalWarning,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: context.getThemeColor(
                appColorTheme: AppColorEnum.darkSand,
              ),
            ),
          )
        ],
      ),
    );
  }
}
