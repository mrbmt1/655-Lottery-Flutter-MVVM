import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartModel {
  final formKey = GlobalKey<FormState>().obs;
  final numbers = List<int>.generate(55, (index) => index + 1).obs;
  final frequency = <int, int?>{}.obs;
  final startCode = Rx<int?>(0);
  final endCode = Rx<int?>(0);
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final jackpot1_winner = Rx<int>(0);
  final jackpot2_winner = Rx<int>(0);
  final jackpot1_prize = Rx<int>(0);
  final jackpot2_prize = Rx<int>(0);
  final viewColumnChart = RxBool(true);
  final viewLineChart = RxBool(true);
  final view55 = RxBool(true);
  final winner = RxBool(true);
  final sortAscending = RxBool(true);
}
