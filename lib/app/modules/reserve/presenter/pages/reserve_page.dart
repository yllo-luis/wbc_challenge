import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:wbc_challenge/app/modules/reserve/presenter/controller/reserve_controller.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/widgets/reserve_dialog_confirmation_widget.dart';
import 'package:wbc_challenge/app/modules/reserve/presenter/widgets/reserve_widget.dart';
import 'package:wbc_challenge/core/constants/app_constants_utils.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:wbc_challenge/core/utils/widget_utils/base_app_bar.dart';
import 'package:wbc_challenge/core/utils/widget_utils/build_base_stack.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReservePage extends StatefulWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends ModularState<ReservePage, ReserveController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: _MountBaseBody(
        controller: controller,
      ),
    );
  }
}

class _MountBaseBody extends StatelessWidget {
  final ReserveController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _MountBaseBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BuildBaseStack(
      basePageBody: ValueListenableBuilder<bool>(
        valueListenable: controller.reserveStore.isLoading,
        builder: (context, isLoading, _) {
          return AnimatedSwitcher(
            duration: AppConstantsUtils.defaultAnimationDuration,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: context.getThemeColor(
                        appColorTheme: AppColorEnum.lightSand,
                      ),
                    ),
                  )
                : ValueListenableBuilder<List<ReserveEntity>>(
                    valueListenable: controller.reserveStore.reserves,
                    builder: (context, reserves, _) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => ReserveWidget(
                          reserve: reserves[index],
                          onTap: () => validateAndReserve(
                            reserve: reserves[index],
                            context: context,
                          ),
                        ),
                        itemCount: reserves.length,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Future<void> validateAndReserve({
    required ReserveEntity reserve,
    required BuildContext context,
  }) async {
    if (reserve.isReserved == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.reservePageWarning(
              DateFormat(AppConstantsUtils.defaultDateFormat)
                  .format(reserve.dateReservation!),
            ),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: context.getThemeColor(),
            ),
          ),
          backgroundColor: context.getThemeColor(
            appColorTheme: AppColorEnum.backgroundBordeaux,
          ),
          action: SnackBarAction(
            onPressed: () => controller.reserveObject(reserve: reserve, confirmReserve: false),
            label: AppLocalizations.of(context)!.appCancel,
          ),
        ),
      );
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            controller.disposeDialogData();
            return true;
          },
          child: CupertinoAlertDialog(
              title: Text(
                AppLocalizations.of(context)!.reserveDialogTitle(
                  reserve.name ?? AppConstantsUtils.emptyString,
                ),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                ),
              ),
              content: ReserveDialogConfirmationWidget(
                formKey: formKey,
                reserve: reserve,
                controller: controller,
              )),
        );
      },
    );
  }
}
