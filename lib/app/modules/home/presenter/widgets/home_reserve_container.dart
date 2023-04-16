import 'package:flutter/material.dart';
import 'package:wbc_challenge/core/extentions/build_context_theme_extension.dart';

class HomeReserveContainer extends StatelessWidget {
  final Widget onLeftRow;
  final Widget onRightRow;
  final Widget onCenter;
  final MainAxisAlignment? optionalMainAxisAlignment;

  const HomeReserveContainer(
      {Key? key,
      required this.onLeftRow,
      required this.onRightRow,
      required this.onCenter,
      this.optionalMainAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: context.getThemeColor().withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: List.from(
          [
            const BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
            )
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment:
            optionalMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: [
          onLeftRow,
          onCenter,
          onRightRow,
        ],
      ),
    );
  }
}
