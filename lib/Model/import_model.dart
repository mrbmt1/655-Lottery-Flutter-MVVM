import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ImportModel extends GetxController {
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

  final prizeValueFormat = Rx<NumberFormat>(NumberFormat.decimalPattern());

  final regularNumber1FocusNode = FocusNode();
  final regularNumber2FocusNode = FocusNode();
  final regularNumber3FocusNode = FocusNode();
  final regularNumber4FocusNode = FocusNode();
  final regularNumber5FocusNode = FocusNode();
  final regularNumber6FocusNode = FocusNode();
  final specialNumberFocusNode = FocusNode();
  final jackpot1WinnerFocusNode = FocusNode();
  final jackpot2WinnerFocusNode = FocusNode();
  final jackpot1PrizeFocusNode = FocusNode();
  final jackpot2PrizeFocusNode = FocusNode();
  final drawPeriodFocusNode = FocusNode();
  final drawDateFocusNode = FocusNode();
  final submitButtonFocusNode = FocusNode();
}
