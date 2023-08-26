import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckingModel extends GetxController {
  final TextEditingController numberController1 = TextEditingController();
  final TextEditingController numberController2 = TextEditingController();
  final TextEditingController numberController3 = TextEditingController();
  final TextEditingController numberController4 = TextEditingController();
  final TextEditingController numberController5 = TextEditingController();
  final TextEditingController numberController6 = TextEditingController();

  final RxString numberController1result = "0".obs;
  final RxString numberController2result = "0".obs;
  final RxString numberController3result = "0".obs;
  final RxString numberController4result = "0".obs;
  final RxString numberController5result = "0".obs;
  final RxString numberController6result = "0".obs;
  final RxString numberControllerspecialresult = "0".obs;
  final RxString drawDates = "".obs;
  final RxString drawCodes = "".obs;
  final RxInt jackpot1prize = 0.obs;
  final RxInt jackpot2prize = 0.obs;

  final RxBool showResult = false.obs;
  final RxBool showResultJackpot1 = false.obs;
  final RxBool showResultJackpot2 = false.obs;
  final RxBool showResult1st = false.obs;
  final RxBool showResult2nd = false.obs;
  final RxBool showResult3rd = false.obs;

  final RxList<String> drawPeriods = <String>[].obs;
  final Rx<Color> number1BorderColor = Colors.white.obs;
  final Rx<Color> number2BorderColor = Colors.white.obs;
  final Rx<Color> number3BorderColor = Colors.white.obs;
  final Rx<Color> number4BorderColor = Colors.white.obs;
  final Rx<Color> number5BorderColor = Colors.white.obs;
  final Rx<Color> number6BorderColor = Colors.white.obs;
  final Rx<Color> number1resultBorderColor = Colors.white.obs;
  final Rx<Color> number2resultBorderColor = Colors.white.obs;
  final Rx<Color> number3resultBorderColor = Colors.white.obs;
  final Rx<Color> number4resultBorderColor = Colors.white.obs;
  final Rx<Color> number5resultBorderColor = Colors.white.obs;
  final Rx<Color> number6resultBorderColor = Colors.white.obs;
  final Rx<Color> numberspecialresultBorderColor = Colors.redAccent.obs;

  final FocusNode numberFocusNode1 = FocusNode();
  final FocusNode numberFocusNode2 = FocusNode();
  final FocusNode numberFocusNode3 = FocusNode();
  final FocusNode numberFocusNode4 = FocusNode();
  final FocusNode numberFocusNode5 = FocusNode();
  final FocusNode numberFocusNode6 = FocusNode();
  final FocusNode unusedFocusNode = FocusNode();
}
