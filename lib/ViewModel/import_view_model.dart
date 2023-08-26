import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/import_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ImportViewModel extends GetxController {
  final ImportModel importModel = ImportModel();

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy', 'vi_VN');
      final String formattedDate = formatter.format(picked);
      importModel.drawDateController.value.text = formattedDate;
    }
  }

  String? validateNumber(String? value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số';
    }

    final number = int.tryParse(value);
    if (number == null || number < 1 || number > 55) {
      return 'Số phải là số tự nhiên từ 1 đến 55';
    }

    final duplicateControllers = [
      importModel.regularNumber1Controller,
      importModel.regularNumber2Controller,
      importModel.regularNumber3Controller,
      importModel.regularNumber4Controller,
      importModel.regularNumber5Controller,
      importModel.regularNumber6Controller,
      importModel.specialNumberController,
    ].where((c) => c != controller);

    if (duplicateControllers.any((c) => c.value.text == value)) {
      return 'Số không được trùng nhau';
    }

    return null;
  }

  Future<bool> checkDrawPeriodExistence(int drawPeriod) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .where('draw_period', isEqualTo: drawPeriod)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void submitForm(BuildContext context) async {
    final form = importModel.formKey.currentState;
    if (form!.validate()) {
      // Check if the draw period already exists
      final drawPeriod =
          int.tryParse(importModel.drawPeriodController.value.text.trim()) ?? 0;
      final drawPeriodExists = await checkDrawPeriodExistence(drawPeriod);

      if (drawPeriodExists) {
        // A document with the given draw period already exists
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text(
                  'Kỳ đã tồn tại, vui lòng chỉnh sửa hoặc xóa kết quả kỳ cũ trước khi import thông tin kỳ mới.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Đóng'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        int jackpot1Winner =
            int.tryParse(importModel.jackpot1Controller.value.text.trim()) ?? 0;
        int jackpot2Winner =
            int.tryParse(importModel.jackpot2Controller.value.text.trim()) ?? 0;
        int prize1Value =
            int.tryParse(importModel.prize1ValueController.value.text.trim()) ??
                0;
        int prize2Value =
            int.tryParse(importModel.prize2ValueController.value.text.trim()) ??
                0;

        int jackpot1Prize =
            jackpot1Winner > 0 ? (prize1Value ~/ jackpot1Winner) : 0;
        int jackpot2Prize =
            jackpot2Winner > 0 ? (prize2Value ~/ jackpot2Winner) : 0;

        await FirebaseFirestore.instance
            .collection('vietlott_655_results')
            .add({
          'number_1':
              importModel.regularNumber1Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber1Controller.value.text.trim()),
          'number_2':
              importModel.regularNumber2Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber2Controller.value.text.trim()),
          'number_3':
              importModel.regularNumber3Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber3Controller.value.text.trim()),
          'number_4':
              importModel.regularNumber4Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber4Controller.value.text.trim()),
          'number_5':
              importModel.regularNumber5Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber5Controller.value.text.trim()),
          'number_6':
              importModel.regularNumber6Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      importModel.regularNumber6Controller.value.text.trim()),
          'special_number': int.tryParse(
              importModel.specialNumberController.value.text.trim()),
          'prize1_value': prize1Value,
          'prize2_value': prize2Value,
          'jackpot1_winner': jackpot1Winner,
          'jackpot1_prize': jackpot1Prize,
          'jackpot2_winner': jackpot2Winner,
          'jackpot2_prize': jackpot2Prize,
          'draw_period':
              int.tryParse(importModel.drawPeriodController.value.text.trim()),
          'draw_date': importModel.drawDateController.value.text.trim(),
          'created_at': FieldValue.serverTimestamp(),
        });
        // Show a notification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thông tin vé số đã được lưu.')),
        );
      }
    }
  }

  void clearData() {
    importModel.regularNumber1Controller.value.clear();
    importModel.regularNumber2Controller.value.clear();
    importModel.regularNumber3Controller.value.clear();
    importModel.regularNumber4Controller.value.clear();
    importModel.regularNumber5Controller.value.clear();
    importModel.regularNumber6Controller.value.clear();
    importModel.specialNumberController.value.clear();
    importModel.prize1ValueController.value.clear();
    importModel.prize2ValueController.value.clear();

    importModel.jackpot1Controller.value.clear();
    importModel.jackpot1prizeController.value.clear();

    importModel.jackpot2Controller.value.clear();
    importModel.jackpot2prizeController.value.clear();

    importModel.drawPeriodController.value.clear();
    importModel.drawDateController.value.clear();
  }
}
