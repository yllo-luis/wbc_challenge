import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReserveWidget extends StatelessWidget {
  final ReserveEntity reserve;
  final Function onTap;

  const ReserveWidget({
    super.key,
    required this.reserve,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 18.0,
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 125,
          width: 135,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.getThemeColor().withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: context.getThemeColor(
                    appColorTheme: AppColorEnum.backgroundBordeaux,
                  ),
                  child: Icon(
                    Icons.outdoor_grill_outlined,
                    color: context.getThemeColor(
                      appColorTheme: reserve.isReserved == false
                          ? AppColorEnum.darkRed
                          : AppColorEnum.lightSand,
                    ),
                    size: 55,
                  ),
                ),
              ),
              Text(
                reserve.name.toString() + reserve.id.toString(),
                style: GoogleFonts.poppins(
                  color: context.getThemeColor(),
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
