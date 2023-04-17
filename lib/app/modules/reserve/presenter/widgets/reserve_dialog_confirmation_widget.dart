import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import 'package:wbc_challenge/app/modules/reserve/presenter/controller/reserve_controller.dart';
import 'package:wbc_challenge/core/constants/app_constants_utils.dart';
import 'package:wbc_challenge/core/enums/app_color_enum.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:wbc_challenge/domain/reserve_entity.dart';

class ReserveDialogConfirmationWidget extends StatelessWidget {
  final ReserveController controller;
  final ReserveEntity reserve;
  final GlobalKey<FormState> formKey;

  const ReserveDialogConfirmationWidget({
    super.key,
    required this.controller,
    required this.reserve,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 205,
        child: ValueListenableBuilder<bool>(
          valueListenable: controller.reserveStore.isReserved,
          builder: (context, isReserved, _) {
            return AnimatedSwitcher(
              duration: AppConstantsUtils.defaultAnimationDuration,
              child: isReserved == false
                  ? Column(
                      children: [
                        _MountForm(
                          formKey: formKey,
                          reserve: reserve,
                          controller: controller,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith(
                                  (_) => context
                                      .getThemeColor(
                                        appColorTheme:
                                            AppColorEnum.backgroundBordeaux,
                                      )
                                      .withOpacity(0.2),
                                ),
                              ),
                              onPressed: () {
                                controller.disposeDialogData();
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.appCancel,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: context.getThemeColor(
                                    appColorTheme:
                                        AppColorEnum.backgroundBordeaux,
                                  ),
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: () =>
                                  controller.reserveObject(reserve: reserve),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (_) => context.getThemeColor(
                                    appColorTheme: AppColorEnum.darkSand,
                                  ),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .homeModalOptionReserve,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Lottie.asset(
                          'assets/lottie_animations/success.json',
                          height: 157,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith(
                                (_) => context
                                    .getThemeColor(
                                      appColorTheme:
                                          AppColorEnum.backgroundBordeaux,
                                    )
                                    .withOpacity(0.2),
                              ),
                            ),
                            onPressed: () {
                              controller.disposeDialogData();
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.appClose,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: context.getThemeColor(
                                    appColorTheme:
                                        AppColorEnum.backgroundBordeaux,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _MountForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ReserveController controller;
  final ReserveEntity reserve;

  const _MountForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.reserve,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2032),
                  );
                  if (date != null) {
                    controller.reserveStore.reservedDate.value = date;
                    controller.dateController.value = TextEditingValue(
                      text: DateFormat(
                        AppConstantsUtils.defaultDateFormat,
                      ).format(date),
                    );
                  }
                },
                child: TextFormField(
                  controller: controller.dateController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.reserveDialogHintText,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.getThemeColor(
                          appColorTheme: AppColorEnum.defaultOrange,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue: reserve.price == 0
                  ? AppLocalizations.of(context)!.reserveDialogHintTextPriceFree
                  : reserve.price.toString(),
              enabled: false,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.reserveDialogHintText,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: context.getThemeColor(
                      appColorTheme: AppColorEnum.defaultOrange,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
