import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckingAllModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController numberController1 = TextEditingController();
  final TextEditingController numberController2 = TextEditingController();
  final TextEditingController numberController3 = TextEditingController();
  final TextEditingController numberController4 = TextEditingController();
  final TextEditingController numberController5 = TextEditingController();
  final TextEditingController numberController6 = TextEditingController();

  final lotteryResults = <Map<String, dynamic>>[].obs;

  // final drawController = TextEditingController();
  final selectedNumbers = <int>[].obs;
  final showResult = false.obs;
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
  final Rx<Color> numberspecialresultBorderColor = Colors.red.obs;

  final FocusNode numberFocusNode1 = FocusNode();
  final FocusNode numberFocusNode2 = FocusNode();
  final FocusNode numberFocusNode3 = FocusNode();
  final FocusNode numberFocusNode4 = FocusNode();
  final FocusNode numberFocusNode5 = FocusNode();
  final FocusNode numberFocusNode6 = FocusNode();

  RxBool viewTriplets = false.obs;
  RxBool viewQuadruplets = false.obs;
  RxBool viewQuintuplets = false.obs;
  RxBool viewSextuplets = false.obs;
  RxBool viewAllResults = true.obs;
  RxBool hasMatchingResults = false.obs;
  RxBool isLoading = false.obs;
}
