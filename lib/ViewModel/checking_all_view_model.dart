import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/checking_all_model.dart';
import 'package:do_so_655/View/widgets/checking_widget/checking_dialog.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckingAllViewModel extends GetxController {
  final CheckingAllModel checkingAllModel = CheckingAllModel();

  bool isNumberMatching(int number) {
    return checkingAllModel.selectedNumbers.contains(number);
  }

  void clearNumbers() {
    checkingAllModel.numberController1.clear();
    checkingAllModel.numberController2.clear();
    checkingAllModel.numberController3.clear();
    checkingAllModel.numberController4.clear();
    checkingAllModel.numberController5.clear();
    checkingAllModel.numberController6.clear();
  }

  int getMatchingNumbersCount(Map<String, dynamic> result) {
    int count = 0;
    for (var number in result['winningNumbers']) {
      if (isNumberMatching(number)) {
        count++;
      }
    }
    if (result['specialNumber'] != null &&
        isNumberMatching(result['specialNumber'])) {
      count++;
    }
    return count;
  }

  Future<void> checkingAllSubmit(BuildContext context) async {
    internetChecking(context);
    List<int> numbers = [
      int.tryParse(checkingAllModel.numberController1.text) ?? 0,
      int.tryParse(checkingAllModel.numberController2.text) ?? 0,
      int.tryParse(checkingAllModel.numberController3.text) ?? 0,
      int.tryParse(checkingAllModel.numberController4.text) ?? 0,
      int.tryParse(checkingAllModel.numberController5.text) ?? 0,
      int.tryParse(checkingAllModel.numberController6.text) ?? 0,
    ];

    // Check for empty input fields
    if (checkingAllModel.numberController1.text.isEmpty ||
        checkingAllModel.numberController2.text.isEmpty ||
        checkingAllModel.numberController3.text.isEmpty ||
        checkingAllModel.numberController4.text.isEmpty ||
        checkingAllModel.numberController5.text.isEmpty ||
        checkingAllModel.numberController6.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const CheckingDialog(
          title: 'Thông báo',
          content: 'Bạn chưa nhập đủ các số',
        ),
      );
      return;
    }

    // Check for numbers less than 55
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i] < 1 || numbers[i] > 55) {
        showDialog(
          context: context,
          builder: (_) => const CheckingDialog(
            title: 'Thông báo',
            content: 'Các số phải nằm trong khoảng từ 1 đến 55',
          ),
        );
        return;
      }
    }

    // Check for duplicate numbers
    if (numbers.toSet().length != numbers.length) {
      showDialog(
        context: context,
        builder: (_) => const CheckingDialog(
          title: 'Thông báo',
          content: 'Các số không được trùng nhau',
        ),
      );
      return;
    }

    if (checkingAllModel.formKey.currentState!.validate()) {
      checkingAllModel.isLoading.value = true;
      // Lấy ra các số đã được chọn
      checkingAllModel.selectedNumbers.clear();
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController1.text));
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController2.text));
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController3.text));
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController4.text));
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController5.text));
      checkingAllModel.selectedNumbers
          .add(int.parse(checkingAllModel.numberController6.text));

      // Lấy ra số kỳ đã chọn

      // Lấy ra thông tin kết quả xổ số từ Firebase
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .orderBy('draw_period', descending: true)
          .get();

      if (result.docs.isNotEmpty) {
        checkingAllModel.lotteryResults.clear();
        for (var doc in result.docs) {
          final data = doc.data();
          // Lấy ra các số đã trúng
          final winningNumbers = [
            data['number_1'],
            data['number_2'],
            data['number_3'],
            data['number_4'],
            data['number_5'],
            data['number_6']
          ];
          final specialNumber = data['special_number'];
          final drawPeriod = data['draw_period'];
          final drawDate = data['draw_date'];

          Map<String, dynamic> lotteryResult = {
            'winningNumbers': winningNumbers,
            'specialNumber': specialNumber,
            'drawPeriod': drawPeriod,
            'drawDate': drawDate,
          };

          checkingAllModel.lotteryResults.add(lotteryResult);

          for (int i = 0; i < 6; i++) {
            if (winningNumbers.contains(checkingAllModel.selectedNumbers[i])) {
              int index =
                  winningNumbers.indexOf(checkingAllModel.selectedNumbers[i]);
              if (index == 0) {
                checkingAllModel.number1resultBorderColor.value = Colors.green;
              } else if (index == 1) {
                checkingAllModel.number2resultBorderColor.value = Colors.green;
              } else if (index == 2) {
                checkingAllModel.number3resultBorderColor.value = Colors.green;
              } else if (index == 3) {
                checkingAllModel.number4resultBorderColor.value = Colors.green;
              } else if (index == 4) {
                checkingAllModel.number5resultBorderColor.value = Colors.green;
              } else if (index == 5) {
                checkingAllModel.number6resultBorderColor.value = Colors.green;
              }
            }
          }
          if (specialNumber != null &&
              checkingAllModel.selectedNumbers.contains(specialNumber)) {
            checkingAllModel.numberspecialresultBorderColor.value = Colors.blue;
          }
        }
        checkingAllModel.showResult.value = true;
        checkingAllModel.isLoading.value = false;
      }
    }
  }

  void showResultDetails(int drawPeriod, BuildContext context) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .where('draw_period', isEqualTo: drawPeriod)
        .get();

    if (snapshot.size > 0) {
      final result = snapshot.docs[0].data();
      final drawDate = result['draw_date'] as String;
      final prize1Value = result['prize1_value'] as int;
      final prize2Value = result['prize2_value'] as int;
      final jackpot1Winner = result['jackpot1_winner'] as int;
      final jackpot2Winner = result['jackpot2_winner'] as int;

      final currencyFormat =
          NumberFormat.decimalPattern('vi'); // Định dạng tiền tệ
      final formattedPrize1Value = currencyFormat.format(prize1Value);
      final formattedPrize2Value = currencyFormat.format(prize2Value);

      final message = 'Kỳ: ${drawPeriod.toString().padLeft(4, '0')}\n'
          'Ngày xổ: $drawDate\n'
          'Giá trị Jackpot 1: ${formattedPrize1Value} VNĐ\n'
          'Giá trị Jackpot 2: ${formattedPrize2Value} VNĐ\n'
          'Số người trúng jackpot 1: ${jackpot1Winner.toString()}\n'
          'Số người trúng jackpot 2: ${jackpot2Winner.toString()}';

      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void clearCheckingAll() {
    checkingAllModel.numberController1.clear();
    checkingAllModel.numberController2.clear();
    checkingAllModel.numberController3.clear();
    checkingAllModel.numberController4.clear();
    checkingAllModel.numberController5.clear();
    checkingAllModel.numberController6.clear();
    checkingAllModel.showResult.value = false;
  }
}
