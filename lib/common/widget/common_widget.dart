import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:impero_task/common/resource/colors.dart';
import 'package:logger/logger.dart';

import '../../di/di_service.dart';
import '../resource/dimen.dart';
import '../utils/enum.dart';

Logger logger = getIt.get<Logger>();

Widget circularScreenLoader({double height = 40}) {
  return Center(
    child: SizedBox(
      height: height,
      width: height,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    ),
  );
}

showCustomToast(
    {required String? text, ToastType toastType = ToastType.Success}) {
  Color backgroundColor;

  switch (toastType) {
    case ToastType.Success:
      backgroundColor = ITColors.primary;
      break;
    case ToastType.Error:
      backgroundColor = ITColors.alertRedColor;
      break;
  }

  // if (kReleaseMode) return;

  BotToast.showCustomText(
    toastBuilder: (CancelFunc cancel) => Align(
      alignment: Alignment.topCenter,
      child: Material(
        child: Container(
          color: backgroundColor,
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                    child: Text(
                      text ?? "",
                      style: const TextStyle(color: ITColors.whiteColor, fontSize: TextSize.small)
                    ),
                  )),
              IconButton(
                onPressed: () => cancel(),
                icon: const Icon(
                  Icons.close,
                  color: ITColors.whiteColor,
                ),
              )
            ],
          ),
        ),
      ),
    ),
    duration:
    Duration(milliseconds: toastType == ToastType.Success ? 1500 : 2000),
    animationDuration: const Duration(milliseconds: 400),
    onlyOne: true,
  );
}