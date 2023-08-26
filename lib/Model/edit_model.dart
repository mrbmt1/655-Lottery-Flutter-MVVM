import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditModel extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final regularNumber1Controller = TextEditingController().obs;
  final regularNumber2Controller = TextEditingController().obs;
  final regularNumber3Controller = TextEditingController().obs;
  final regularNumber4Controller = TextEditingController().obs;
  final regularNumber5Controller = TextEditingController().obs;
  final regularNumber6Controller = TextEditingController().obs;
  final specialNumberController = TextEditingController().obs;
  final prize1ValueController = TextEditingController().obs;
  final prize2ValueController = TextEditingController().obs;

  final jackpot1Controller = TextEditingController().obs;
  final jackpot1prizeController = TextEditingController().obs;

  final jackpot2Controller = TextEditingController().obs;
  final jackpot2prizeController = TextEditingController().obs;

  final drawPeriodController = TextEditingController().obs;
  final drawDateController = TextEditingController().obs;
  final prizeValueFormat = NumberFormat.decimalPattern();
  RxList<String> drawPeriods = <String>[].obs;
}
