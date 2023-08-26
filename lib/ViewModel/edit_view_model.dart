import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditViewModel extends GetxController {
  final EditModel editModel = EditModel();

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
      editModel.drawDateController.value.text = formattedDate;
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
      editModel.regularNumber1Controller,
      editModel.regularNumber2Controller,
      editModel.regularNumber3Controller,
      editModel.regularNumber4Controller,
      editModel.regularNumber5Controller,
      editModel.regularNumber6Controller,
      editModel.specialNumberController,
    ].where((c) => c != controller);

    if (duplicateControllers.any((c) => c.value.text == value)) {
      return 'Số không được trùng nhau';
    }

    return null;
  }

  Future<void> getDrawPeriods() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .orderBy('draw_period', descending: true)
          .get();
      editModel.drawPeriods.value =
          result.docs.map((doc) => doc.get('draw_period').toString()).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadDrawResult(String drawPeriod) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .where('draw_period', isEqualTo: int.parse(drawPeriod))
          .get();
      final data = result.docs.first.data();

      editModel.drawDateController.value.text = (data['draw_date']);
      editModel.regularNumber1Controller.value.text =
          data['number_1'].toString();
      editModel.regularNumber2Controller.value.text =
          data['number_2'].toString();
      editModel.regularNumber3Controller.value.text =
          data['number_3'].toString();
      editModel.regularNumber4Controller.value.text =
          data['number_4'].toString();
      editModel.regularNumber5Controller.value.text =
          data['number_5'].toString();
      editModel.regularNumber6Controller.value.text =
          data['number_6'].toString();
      editModel.specialNumberController.value.text =
          data['special_number'].toString();
      editModel.prize1ValueController.value.text =
          data['prize1_value'].toString();
      editModel.prize2ValueController.value.text =
          data['prize2_value'].toString();
      editModel.jackpot1Controller.value.text =
          data['jackpot1_winner'].toString();
      editModel.jackpot1prizeController.value.text =
          data['jackpot1_prize'].toString();
      editModel.jackpot2Controller.value.text =
          data['jackpot2_winner'].toString();
      editModel.jackpot2prizeController.value.text =
          data['jackpot2_prize'].toString();
    } catch (e) {
      print(e);
    }
  }

  void updateForm(BuildContext context) async {
    final form = editModel.formKey.currentState;
    if (form!.validate()) {
      int jackpot1Winner =
          int.tryParse(editModel.jackpot1Controller.value.text.trim()) ?? 0;
      int jackpot2Winner =
          int.tryParse(editModel.jackpot2Controller.value.text.trim()) ?? 0;
      int prize1Value =
          int.tryParse(editModel.prize1ValueController.value.text.trim()) ?? 0;
      int prize2Value =
          int.tryParse(editModel.prize2ValueController.value.text.trim()) ?? 0;

      int jackpot1Prize =
          jackpot1Winner > 0 ? (prize1Value ~/ jackpot1Winner) : 0;
      int jackpot2Prize =
          jackpot2Winner > 0 ? (prize2Value ~/ jackpot2Winner) : 0;

      final drawPeriod =
          int.tryParse(editModel.drawPeriodController.value.text.trim());

      try {
        final result = await FirebaseFirestore.instance
            .collection('vietlott_655_results')
            .where('draw_period', isEqualTo: drawPeriod)
            .get();
        final documentId = result.docs.first.id;
        await FirebaseFirestore.instance
            .collection('vietlott_655_results')
            .doc(documentId)
            .update({
          'number_1':
              editModel.regularNumber1Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber1Controller.value.text.trim()),
          'number_2':
              editModel.regularNumber2Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber2Controller.value.text.trim()),
          'number_3':
              editModel.regularNumber3Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber3Controller.value.text.trim()),
          'number_4':
              editModel.regularNumber4Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber4Controller.value.text.trim()),
          'number_5':
              editModel.regularNumber5Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber5Controller.value.text.trim()),
          'number_6':
              editModel.regularNumber6Controller.value.text.trim().isEmpty
                  ? null
                  : int.tryParse(
                      editModel.regularNumber6Controller.value.text.trim()),
          'special_number':
              int.tryParse(editModel.specialNumberController.value.text.trim()),
          'prize1_value': prize1Value,
          'prize2_value': prize2Value,
          'jackpot1_winner': jackpot1Winner,
          'jackpot1_prize': jackpot1Prize,
          'jackpot2_winner': jackpot2Winner,
          'jackpot2_prize': jackpot2Prize,
          'draw_period': drawPeriod,
          'draw_date': editModel.drawDateController.value.text.trim(),
          'updated_at': FieldValue.serverTimestamp(),
        });
        // Show a notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thông tin vé số đã được cập nhật.')),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void deleteForm(BuildContext context) async {
    final drawPeriod =
        int.tryParse(editModel.drawPeriodController.value.text.trim());
    try {
      final result = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .where('draw_period', isEqualTo: drawPeriod)
          .get();
      final documentId = result.docs.first.id;

      // Hiển thị hộp thoại xác nhận trước khi xóa
      // ignore: use_build_context_synchronously
      final confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xác nhận xóa'),
            content:
                Text('Bạn có chắc chắn muốn xóa thông tin vé số này không?'),
            actions: [
              TextButton(
                child: Text('Hủy'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Xóa'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('vietlott_655_results')
                      .doc(documentId)
                      .delete();
                  // Đóng hộp thoại
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      // Nếu người dùng đã xác nhận muốn xóa, hiển thị thông báo và chuyển đến màn hình chỉnh sửa
      if (confirmed == true) {
        // Hiển thị thông báo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thông tin vé số đã được xóa.')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        // Rebuild the existing EditVietlott655Form screen
        getDrawPeriods();
      }
    } catch (e) {
      print(e);
    }
  }
}
