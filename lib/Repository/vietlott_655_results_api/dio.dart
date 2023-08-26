import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<void> getResultsFromAPItoFirebase(BuildContext context) async {
  final dio = Dio();
  const apiURL =
      'https://mrbmt1.github.io/vietlott_655_results_api/data/vietlott_result_api.json';

  try {
    Response response = await dio.get(apiURL);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(response.data);

      int currentDrawPeriod = await getCurrentDrawPeriodFromFirestore();
      String newResultsMessage = ''; // Initialize an empty message

      for (Map<String, dynamic> targetData in data) {
        if (validateData(targetData, context)) {
          int targetDrawPeriod = targetData['draw_period'];

          if (targetDrawPeriod > currentDrawPeriod) {
            await FirebaseFirestore.instance
                .collection('vietlott_655_results')
                .doc('$targetDrawPeriod')
                .set({
              'draw_period': targetDrawPeriod,
              'draw_date': targetData['draw_date'],
              'number_1': int.tryParse(targetData['number_1'].toString()) ?? 0,
              'number_2': int.tryParse(targetData['number_2'].toString()) ?? 0,
              'number_3': int.tryParse(targetData['number_3'].toString()) ?? 0,
              'number_4': int.tryParse(targetData['number_4'].toString()) ?? 0,
              'number_5': int.tryParse(targetData['number_5'].toString()) ?? 0,
              'number_6': int.tryParse(targetData['number_6'].toString()) ?? 0,
              'special_number':
                  int.tryParse(targetData['special_number'].toString()) ?? 0,
              'prize1_value': targetData['prize1_value'],
              'prize2_value': targetData['prize2_value'],
              'jackpot1_winner': targetData['jackpot1_winner'],
              'jackpot1_prize': targetData['jackpot1_prize'],
              'jackpot2_winner': targetData['jackpot2_winner'],
              'jackpot2_prize': targetData['jackpot2_prize'],
              'created_at': FieldValue.serverTimestamp(),
            });

            // Append the new result details to the message
            newResultsMessage += 'Kỳ $targetDrawPeriod, ';
          }
        }
      }

      if (newResultsMessage.isNotEmpty) {
        newResultsMessage =
            newResultsMessage.substring(0, newResultsMessage.length - 2);
        showSnackbar('Đã thêm dữ liệu $newResultsMessage', context);
      } else {
        showSnackbar('Không có dữ liệu mới được thêm.', context);
      }
    } else {
      showSnackbar(
          'Lỗi tải dữ liệu. Trạng thái lỗi: ${response.statusCode}', context);
    }
  } catch (e) {
    showSnackbar('Lỗi tải dữ liệu: $e', context);
  }
}

bool validateData(Map<String, dynamic> data, BuildContext context) {
  if (!validateNumbers(data, context) ||
      !validateDateFormat(data['draw_date'])) {
    return false;
  }

  return true;
}

bool validateNumbers(Map<String, dynamic> data, BuildContext context) {
  int number1 = int.tryParse(data['number_1'].toString()) ?? -1;
  int number2 = int.tryParse(data['number_2'].toString()) ?? -1;
  int number3 = int.tryParse(data['number_3'].toString()) ?? -1;
  int number4 = int.tryParse(data['number_4'].toString()) ?? -1;
  int number5 = int.tryParse(data['number_5'].toString()) ?? -1;
  int number6 = int.tryParse(data['number_6'].toString()) ?? -1;
  int specialNumber = int.tryParse(data['special_number'].toString()) ?? -1;
  int prize1Value = int.tryParse(data['prize1_value'].toString()) ?? -1;
  List<String> errors = [];

  if (number1 < 1 ||
      number1 > 55 ||
      number2 < 1 ||
      number2 > 55 ||
      number3 < 1 ||
      number3 > 55 ||
      number4 < 1 ||
      number4 > 55 ||
      number5 < 1 ||
      number5 > 55 ||
      number6 < 1 ||
      number6 > 55 ||
      specialNumber < 1 ||
      specialNumber > 55) {
    errors.add('Số 1 nằm ngoài khoảng 1-55.');
  }
  if (number1 == number2 ||
      number1 == number3 ||
      number1 == number4 ||
      number1 == number5 ||
      number1 == number6 ||
      number1 == specialNumber ||
      number2 == number3 ||
      number2 == number4 ||
      number2 == number5 ||
      number2 == number6 ||
      number2 == specialNumber ||
      number3 == number4 ||
      number3 == number5 ||
      number3 == number6 ||
      number3 == specialNumber ||
      number4 == number5 ||
      number4 == number6 ||
      number4 == specialNumber ||
      number5 == number6 ||
      number5 == specialNumber ||
      number6 == specialNumber) {
    errors.add('Có số trùng lặp.');
  }
  if (prize1Value < 30000000000) {
    errors.add('Giá trị Jackpot 1 nhỏ hơn 30 tỷ.');
  }

  if (errors.isNotEmpty) {
    String errorMessage = errors.join('\n');
    showSnackbar(errorMessage, context);
    return false;
  }

  return true;
}

bool validateDateFormat(String date) {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  try {
    dateFormat.parseStrict(date);
    return true;
  } catch (e) {
    return false;
  }
}

void showSnackbar(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<int> getCurrentDrawPeriodFromFirestore() async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('vietlott_655_results')
      .orderBy('draw_period', descending: true)
      .limit(1)
      .get()
      .then((querySnapshot) => querySnapshot.docs.first);

  return snapshot.exists ? snapshot['draw_period'] : 0;
}
