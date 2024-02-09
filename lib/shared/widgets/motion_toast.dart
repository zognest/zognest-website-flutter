import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
void displaySuccess(context) {
  MotionToast displaySuccess = MotionToast.success.call(
      width: 300,
      height: 100,
      dismissable: true,
      animationDuration: const Duration(microseconds:1000),
      animationCurve: Curves.easeIn,
      barrierColor:Colors.blue,
      position: MotionToastPosition.center,
      toastDuration: const Duration(seconds:6),
      iconSize: 50,
      iconType:IconType.materialDesign ,
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromLeft,
      description:
         const Text(
          'success',
          style: TextStyle(color:Colors.black, fontSize: 25),
        ),
  );
  displaySuccess.show(context);
  Future.delayed(const Duration(seconds: 4)).then((value) {
    displaySuccess.closeOverlay();
  });
}

