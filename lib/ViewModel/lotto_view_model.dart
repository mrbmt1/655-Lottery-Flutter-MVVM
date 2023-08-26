import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/lotto_model.dart';
import 'package:do_so_655/View/widgets/lottery_widget/draw_code_dialog_wiget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/draw_date_dialog_widget.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotteryViewModel extends GetxController {
  final LotteryModel lotteryModel = LotteryModel();

  Future<void> loadData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      lotteryModel.drawDate.value = data['draw_date'];
      lotteryModel.drawCode.value = data['draw_period'].toString();
      lotteryModel.regularNumber1Controller.value = data['number_1'];
      lotteryModel.regularNumber2Controller.value = data['number_2'];
      lotteryModel.regularNumber3Controller.value = data['number_3'];
      lotteryModel.regularNumber4Controller.value = data['number_4'];
      lotteryModel.regularNumber5Controller.value = data['number_5'];
      lotteryModel.regularNumber6Controller.value = data['number_6'];
      lotteryModel.specialNumberController.value = data['special_number'];
      lotteryModel.prize1Value.value = data['prize1_value'];
      lotteryModel.prize2Value.value = data['prize2_value'];
      lotteryModel.jackpot1Winner.value = data['jackpot1_winner'];
      lotteryModel.jackpot1Prize.value = data['jackpot1_prize'];
      lotteryModel.jackpot2Winner.value = data['jackpot2_winner'];
      lotteryModel.jackpot2Prize.value = data['jackpot2_prize'];
    }
  }

  Future<void> loadDraws() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> drawDataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      final List<String> drawCodes = drawDataList
          .map((drawData) => drawData['draw_period'].toString())
          .toList();

      final List<String> jackpotWinningDraws = drawDataList
          .where((drawData) =>
              drawData['jackpot1_winner'] > 0 ||
              drawData['jackpot2_winner'] > 0)
          .map((drawData) => drawData['draw_period'].toString())
          .toList();

      lotteryModel.drawCodes.assignAll(drawCodes);
      lotteryModel.jackpotWinningDraws.assignAll(jackpotWinningDraws);
    }
  }

  Future<void> loadDrawDates() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> drawDataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      final List<String> drawDates = drawDataList
          .map((drawData) => drawData['draw_date'].toString())
          .toList();

      final List<String> jackpotWinningDrawDates = drawDataList
          .where((drawData) =>
              drawData['jackpot1_winner'] > 0 ||
              drawData['jackpot2_winner'] > 0)
          .map((drawData) => drawData['draw_date'].toString())
          .toList();

      lotteryModel.drawDates.assignAll(drawDates);
      lotteryModel.jackpotWinningDrawDates.assignAll(jackpotWinningDrawDates);
    }
  }

  void showDrawDates(BuildContext context) async {
    internetChecking(context);
    await loadDrawDates();

    List<String> filteredDrawDates = List<String>.from(lotteryModel.drawDates);

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController searchController = TextEditingController();
        return DrawDateDialog(
          filteredDrawDates: filteredDrawDates,
          onDrawDateSelected: (drawDate) async {
            Navigator.of(context).pop();
            await loadDataForDrawDate(drawDate);
          },
        );
      },
    );
  }

  void showDrawCodes(BuildContext context) async {
    internetChecking(context);
    await loadDraws();
    List<String> filteredDrawCodes = List<String>.from(lotteryModel.drawCodes);
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DrawCodeDialog(
          filteredDrawCodes: filteredDrawCodes,
          onDrawCodeSelected: (drawCode) async {
            Navigator.of(context).pop();
            await loadDataForDraw(drawCode);
          },
        );
      },
    );
  }

  Future<void> loadDataForDrawDate(String drawDate) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .where('draw_date', isEqualTo: drawDate)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      lotteryModel.drawDate.value = data['draw_date'];
      lotteryModel.drawCode.value = data['draw_period'].toString();
      lotteryModel.regularNumber1Controller.value = data['number_1'];
      lotteryModel.regularNumber2Controller.value = data['number_2'];
      lotteryModel.regularNumber3Controller.value = data['number_3'];
      lotteryModel.regularNumber4Controller.value = data['number_4'];
      lotteryModel.regularNumber5Controller.value = data['number_5'];
      lotteryModel.regularNumber6Controller.value = data['number_6'];
      lotteryModel.specialNumberController.value = data['special_number'];
      lotteryModel.prize1Value.value = data['prize1_value'];
      lotteryModel.prize2Value.value = data['prize2_value'];
      lotteryModel.jackpot1Winner.value = data['jackpot1_winner'];
      lotteryModel.jackpot1Prize.value = data['jackpot1_prize'];
      lotteryModel.jackpot2Winner.value = data['jackpot2_winner'];
      lotteryModel.jackpot2Prize.value = data['jackpot2_prize'];
    }
  }

  Future<void> loadDataForDraw(String drawCode) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .where('draw_period', isEqualTo: int.parse(drawCode))
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      lotteryModel.drawDate.value = data['draw_date'];
      lotteryModel.drawCode.value = data['draw_period'].toString();
      lotteryModel.regularNumber1Controller.value = data['number_1'];
      lotteryModel.regularNumber2Controller.value = data['number_2'];
      lotteryModel.regularNumber3Controller.value = data['number_3'];
      lotteryModel.regularNumber4Controller.value = data['number_4'];
      lotteryModel.regularNumber5Controller.value = data['number_5'];
      lotteryModel.regularNumber6Controller.value = data['number_6'];
      lotteryModel.specialNumberController.value = data['special_number'];
      lotteryModel.prize1Value.value = data['prize1_value'];
      lotteryModel.prize2Value.value = data['prize2_value'];
      lotteryModel.jackpot1Winner.value = data['jackpot1_winner'];
      lotteryModel.jackpot1Prize.value = data['jackpot1_prize'];
      lotteryModel.jackpot2Winner.value = data['jackpot2_winner'];
      lotteryModel.jackpot2Prize.value = data['jackpot2_prize'];
    }
  }

  Future<void> handleHorizontalDragEnd(
    DragEndDetails details,
    BuildContext context,
    LotteryViewModel lotteryViewModel,
  ) async {
    internetChecking(context);

    final drawCodeValue = int.parse(
      lotteryModel.drawCode.value,
    );

    if (details.primaryVelocity! < 0) {
      await loadDataForDraw((drawCodeValue + 1).toString());
    } else if (details.primaryVelocity! > 0) {
      await loadDataForDraw((drawCodeValue - 1).toString());
    }
  }
}
