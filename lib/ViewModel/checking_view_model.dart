import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/Checking_model.dart';
import 'package:do_so_655/View/widgets/checking_widget/checking_dialog.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckingViewModel extends GetxController {
  final CheckingModel checkingModel = CheckingModel();
  final formKey = GlobalKey<FormState>();
  final TextEditingController drawController = TextEditingController();
  final List<int> selectedNumbers = [];
  final RxString suggestion = ''.obs;

  Future<void> getDrawPeriods() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .orderBy('draw_period', descending: true)
          .get();
      checkingModel.drawPeriods.value =
          result.docs.map((doc) => doc.get('draw_period').toString()).toList();
    } catch (e) {
      print(e);
    }
  }

  void clearNumbers() {
    checkingModel.numberController1.clear();
    checkingModel.numberController2.clear();
    checkingModel.numberController3.clear();
    checkingModel.numberController4.clear();
    checkingModel.numberController5.clear();
    checkingModel.numberController6.clear();
  }

  Future<void> checkingResults(BuildContext context) async {
    internetChecking(context);

    List<int> numbers = [
      int.tryParse(checkingModel.numberController1.text) ?? 0,
      int.tryParse(checkingModel.numberController2.text) ?? 0,
      int.tryParse(checkingModel.numberController3.text) ?? 0,
      int.tryParse(checkingModel.numberController4.text) ?? 0,
      int.tryParse(checkingModel.numberController5.text) ?? 0,
      int.tryParse(checkingModel.numberController6.text) ?? 0,
    ];

    // Check for empty input fields
    if (checkingModel.numberController1.text.isEmpty ||
        checkingModel.numberController2.text.isEmpty ||
        checkingModel.numberController3.text.isEmpty ||
        checkingModel.numberController4.text.isEmpty ||
        checkingModel.numberController5.text.isEmpty ||
        checkingModel.numberController6.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const CheckingDialog(
          title: 'Thông báo',
          content: 'Bạn chưa nhập đủ các số',
        ),
      );
      return;
    }

    if (drawController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const CheckingDialog(
          title: 'Thông báo',
          content: 'Bạn chưa nhập kỳ',
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

    checkingModel.number1resultBorderColor.value = Colors.white;
    checkingModel.number2resultBorderColor.value = Colors.white;
    checkingModel.number3resultBorderColor.value = Colors.white;
    checkingModel.number4resultBorderColor.value = Colors.white;
    checkingModel.number5resultBorderColor.value = Colors.white;
    checkingModel.number6resultBorderColor.value = Colors.white;
    checkingModel.numberspecialresultBorderColor.value = Colors.redAccent;

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
    if (formKey.currentState!.validate()) {
      // Lấy ra các số đã được chọn
      selectedNumbers.clear();
      selectedNumbers.add(int.parse(checkingModel.numberController1.text));
      selectedNumbers.add(int.parse(checkingModel.numberController2.text));
      selectedNumbers.add(int.parse(checkingModel.numberController3.text));
      selectedNumbers.add(int.parse(checkingModel.numberController4.text));
      selectedNumbers.add(int.parse(checkingModel.numberController5.text));
      selectedNumbers.add(int.parse(checkingModel.numberController6.text));

      // Lấy ra số kỳ đã chọn
      final drawPeriod = int.parse(drawController.text);

      // Lấy ra thông tin kết quả xổ số từ Firebase
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .where('draw_period', isEqualTo: drawPeriod)
          .get();

      if (result.docs.isNotEmpty) {
        final data = result.docs.first.data();
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
        final drawCodes = data['draw_period'];
        final drawDates = data['draw_date'];
        checkingModel.jackpot1prize.value = data['prize1_value'];
        checkingModel.jackpot2prize.value = data['prize2_value'];

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController1.text)) ||
            int.parse(checkingModel.numberController1.text) == specialNumber) {
          checkingModel.number1BorderColor.value = Colors.green;
        } else {
          checkingModel.number1BorderColor.value = Colors.white;
        }

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController2.text)) ||
            int.parse(checkingModel.numberController2.text) == specialNumber) {
          checkingModel.number2BorderColor.value = Colors.green;
        } else {
          checkingModel.number2BorderColor.value = Colors.white;
        }

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController3.text)) ||
            int.parse(checkingModel.numberController3.text) == specialNumber) {
          checkingModel.number3BorderColor.value = Colors.green;
        } else {
          checkingModel.number3BorderColor.value = Colors.white;
        }

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController4.text)) ||
            int.parse(checkingModel.numberController4.text) == specialNumber) {
          checkingModel.number4BorderColor.value = Colors.green;
        } else {
          checkingModel.number4BorderColor.value = Colors.white;
        }

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController5.text)) ||
            int.parse(checkingModel.numberController5.text) == specialNumber) {
          checkingModel.number5BorderColor.value = Colors.green;
        } else {
          checkingModel.number5BorderColor.value = Colors.white;
        }

        if (winningNumbers
                .contains(int.parse(checkingModel.numberController6.text)) ||
            int.parse(checkingModel.numberController6.text) == specialNumber) {
          checkingModel.number6BorderColor.value = Colors.green;
        } else {
          checkingModel.number6BorderColor.value = Colors.white;
        }

        checkingModel.numberController1result.value =
            winningNumbers[0].toString();
        checkingModel.numberController2result.value =
            winningNumbers[1].toString();
        checkingModel.numberController3result.value =
            winningNumbers[2].toString();
        checkingModel.numberController4result.value =
            winningNumbers[3].toString();
        checkingModel.numberController5result.value =
            winningNumbers[4].toString();
        checkingModel.numberController6result.value =
            winningNumbers[5].toString();
        checkingModel.numberControllerspecialresult.value =
            specialNumber.toString();
        checkingModel.drawCodes.value = drawCodes.toString();
        checkingModel.drawDates.value = drawDates.toString();

        for (int i = 0; i < 6; i++) {
          if (winningNumbers.contains(selectedNumbers[i])) {
            int index = winningNumbers.indexOf(selectedNumbers[i]);
            if (index == 0) {
              checkingModel.number1resultBorderColor.value = Colors.green;
            } else if (index == 1) {
              checkingModel.number2resultBorderColor.value = Colors.green;
            } else if (index == 2) {
              checkingModel.number3resultBorderColor.value = Colors.green;
            } else if (index == 3) {
              checkingModel.number4resultBorderColor.value = Colors.green;
            } else if (index == 4) {
              checkingModel.number5resultBorderColor.value = Colors.green;
            } else if (index == 5) {
              checkingModel.number6resultBorderColor.value = Colors.green;
            }
          }
        }
        if (specialNumber != null && selectedNumbers.contains(specialNumber)) {
          checkingModel.numberspecialresultBorderColor.value =
              Colors.lightGreenAccent;
        }

        // Tính số lượng số trùng với các số trong kết quả xổ số
        int matchingNumbers = 0;
        for (int i = 0; i < selectedNumbers.length; i++) {
          if (winningNumbers.contains(selectedNumbers[i])) {
            matchingNumbers++;
          }
        }
        // Kiểm tra số trùng với special number
        bool hasSpecialNumber = selectedNumbers.contains(specialNumber);

        // Xử lý kết quả trúng thưởng
        if (matchingNumbers == 6) {
          showDialog(
            context: context,
            builder: (_) => CheckingDialog(
              title: 'Thông báo',
              content:
                  'Chúc mừng bạn đã trúng JACKPOT 1 với giá trị ${(data['prize1_value']).toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (match) => '${match[1]}.',
                      ).toString()} VNĐ',
            ),
          );

          checkingModel.showResultJackpot1.value = true;
          checkingModel.showResultJackpot2.value = false;
          checkingModel.showResult1st.value = false;
          checkingModel.showResult2nd.value = false;
          checkingModel.showResult3rd.value = false;
        } else if (matchingNumbers == 5 && hasSpecialNumber) {
          showDialog(
            context: context,
            builder: (_) => CheckingDialog(
              title: 'Thông báo',
              content:
                  'Chúc mừng bạn đã trúng JACKPOT 2 với giá trị ${(data['prize2_value']).toStringAsFixed(0).replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (match) => '${match[1]}.',
                      ).toString()} VNĐ',
            ),
          );
          checkingModel.showResultJackpot1.value = false;
          checkingModel.showResultJackpot2.value = true;
          checkingModel.showResult1st.value = false;
          checkingModel.showResult2nd.value = false;
          checkingModel.showResult3rd.value = false;
        } else if (matchingNumbers == 5) {
          showDialog(
            context: context,
            builder: (_) => const CheckingDialog(
              title: 'Thông báo',
              content:
                  'Chúc mừng bạn đã trúng Giải Nhất với giá trị 40 triệu đồng',
            ),
          );

          checkingModel.showResultJackpot1.value = false;
          checkingModel.showResultJackpot2.value = false;
          checkingModel.showResult1st.value = true;
          checkingModel.showResult2nd.value = false;
          checkingModel.showResult3rd.value = false;
        } else if (matchingNumbers == 4) {
          showDialog(
            context: context,
            builder: (_) => const CheckingDialog(
              title: 'Thông báo',
              content:
                  'Chúc mừng bạn đã trúng Giải Nhì với giá trị 500.000 đồng',
            ),
          );

          checkingModel.showResultJackpot1.value = false;
          checkingModel.showResultJackpot2.value = false;
          checkingModel.showResult1st.value = false;
          checkingModel.showResult2nd.value = true;
          checkingModel.showResult3rd.value = false;
        } else if (matchingNumbers == 3) {
          showDialog(
            context: context,
            builder: (_) => const CheckingDialog(
              title: 'Thông báo',
              content: 'Chúc mừng bạn đã trúng Giải Ba với giá trị 50.000 đồng',
            ),
          );
          checkingModel.showResultJackpot1.value = false;
          checkingModel.showResultJackpot2.value = false;
          checkingModel.showResult1st.value = false;
          checkingModel.showResult2nd.value = false;
          checkingModel.showResult3rd.value = true;
        } else {
          showDialog(
            context: context,
            builder: (_) => const CheckingDialog(
              title: 'Thông báo',
              content: 'Tiếc quá không trúng rồi!',
            ),
          );
          checkingModel.showResultJackpot1.value = false;
          checkingModel.showResultJackpot2.value = false;
          checkingModel.showResult1st.value = false;
          checkingModel.showResult2nd.value = false;
          checkingModel.showResult3rd.value = false;
        }
      } else {
        showDialog(
          context: context,
          builder: (_) => const CheckingDialog(
            title: 'Thông báo',
            content: 'Không tìm thấy kết quả',
          ),
        );
        checkingModel.showResultJackpot1.value = false;
        checkingModel.showResultJackpot2.value = false;
        checkingModel.showResult1st.value = false;
        checkingModel.showResult2nd.value = false;
        checkingModel.showResult3rd.value = false;
      }
      checkingModel.showResult.value = true;
    }
  }

  void clearDataChecking() {
    selectedNumbers.clear();
    drawController.clear();
    checkingModel.showResult.value = false;
    checkingModel.number1BorderColor.value = Colors.white;
    checkingModel.number2BorderColor.value = Colors.white;
    checkingModel.number3BorderColor.value = Colors.white;
    checkingModel.number4BorderColor.value = Colors.white;
    checkingModel.number5BorderColor.value = Colors.white;
    checkingModel.number6BorderColor.value = Colors.white;
    checkingModel.numberController1.clear();
    checkingModel.numberController2.clear();
    checkingModel.numberController3.clear();
    checkingModel.numberController4.clear();
    checkingModel.numberController5.clear();
    checkingModel.numberController6.clear();
  }

  void onSuggestionSelected(String suggestion) {
    this.suggestion.value = suggestion;
    drawController.text = suggestion;
  }

  List<String> getSuggestions(String pattern) {
    return checkingModel.drawPeriods
        .where(
            (period) => period.toLowerCase().startsWith(pattern.toLowerCase()))
        .toList();
  }
}
