import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/Model/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartViewModel extends GetxController {
  void toggleViewColumnChart() {
    chartModel.viewColumnChart.toggle();
  }

  void toggleViewLineChart() {
    chartModel.viewLineChart.toggle();
  }

  void toggleView55() {
    chartModel.view55.toggle();
  }

  void toggleViewWinner() {
    chartModel.winner.toggle();
  }

  void toggleSortAscending() {
    chartModel.sortAscending.toggle();
  }

  final ChartModel chartModel = ChartModel();
  int numOfDrawPeriods = 1;

  void getData(int start, int end) async {
    if (start != null && end != null) {
      int startCode = start;
      int endCode = end;
      if (start != null && end != null) {
        endCode = end;
      }
      numOfDrawPeriods = endCode - startCode + 1;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vietlott_655_results')
          .where('draw_period', isGreaterThanOrEqualTo: startCode)
          .where('draw_period', isLessThanOrEqualTo: endCode)
          .get();

      List<DocumentSnapshot> docs = snapshot.docs;
      numOfDrawPeriods = docs.length;

      // Tính toán tần suất của các số
      for (int i = 1; i <= 55; i++) {
        chartModel.frequency[i] = 0;
      }

      for (var doc in docs) {
        for (int i = 0; i <= 6; i++) {
          if (doc.data() != null &&
              (doc.data() as Map<String, dynamic>).containsKey('number_$i')) {
            int? number = doc.get('number_$i');
            if (number != null) {
              chartModel.frequency[number] =
                  (chartModel.frequency[number] ?? 0) + 1;
            }
          }
        }

        if ((doc.data() as Map<String, dynamic>)
            .containsKey('special_number')) {
          int? specialNumber = doc.get('special_number');
          if (specialNumber != null) {
            chartModel.frequency[specialNumber] =
                (chartModel.frequency[specialNumber] ?? 0) + 1;
          }
        }
      }

      // Lấy thông tin giải thưởng từ cơ sở dữ liệu
      num jackpot1_winner = 0;
      num jackpot2_winner = 0;
      num jackpot1_prize = 0;
      num jackpot2_prize = 0;
      for (var doc in docs) {
        if ((doc.data() as Map<String, dynamic>)
            .containsKey('jackpot1_winner')) {
          jackpot1_winner += doc.get('jackpot1_winner');
        }
        if ((doc.data() as Map<String, dynamic>)
            .containsKey('jackpot2_winner')) {
          jackpot2_winner += doc.get('jackpot2_winner');
        }
        if ((doc.data() as Map<String, dynamic>)
            .containsKey('jackpot1_prize')) {
          jackpot1_prize += doc.get('jackpot1_prize');
        }
        if ((doc.data() as Map<String, dynamic>)
            .containsKey('jackpot2_prize')) {
          jackpot2_prize += doc.get('jackpot2_prize');
        }
      }

      // Gán giá trị mới cho các biến instance
      chartModel.jackpot1_winner.value = jackpot1_winner.toInt();
      chartModel.jackpot2_winner.value = jackpot2_winner.toInt();
      chartModel.jackpot1_prize.value = jackpot1_prize.toInt();
      chartModel.jackpot2_prize.value = jackpot2_prize.toInt();
    }
  }

  List<charts.Series<ChartData, String>> createSampleData() {
    List<ChartData> data = [];
    for (int i = 1; i <= 55; i++) {
      int count = chartModel.frequency[i] ?? 0;
      data.add(ChartData(i.toString(), count));
    }

    // Sắp xếp dữ liệu theo thứ tự tăng dần hoặc giảm dần nếu đã được bấm vào icon button
    if (!chartModel.sortAscending.value) {
      data.sort((a, b) => b.count.compareTo(a.count));
    }

    return [
      charts.Series<ChartData, String>(
        id: 'frequency',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData data, _) => data.number,
        measureFn: (ChartData data, _) => data.count,
        data: data,
      ),
    ];
  }

  List<charts.Series<LineChartData, int>> createSampleLineChartData() {
    List<LineChartData> data = [];
    for (int i = 1; i <= 55; i++) {
      int count = chartModel.frequency[i] ?? 0;
      data.add(LineChartData(i, count));
    }

    return [
      charts.Series<LineChartData, int>(
        id: 'frequency',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LineChartData data, _) => data.number,
        measureFn: (LineChartData data, _) => data.count,
        data: data,
      )
    ];
  }

  void sortFrequency() {
    List<MapEntry<int, int?>> sortedEntries = chartModel.frequency.entries
        .toList()
      ..sort((a, b) => a.value!.compareTo(b.value!));

    if (!chartModel.sortAscending.value) {
      sortedEntries = sortedEntries.reversed.toList();
    }

    chartModel.frequency.value = Map.fromEntries(sortedEntries);
  }

  void sortColumnChartAscending(BuildContext context) {
    chartModel.sortAscending.value = true;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dữ liệu đã được sắp xếp theo thứ tự từ 1 đến 55'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void sortColumnChartDescending(BuildContext context) {
    chartModel.sortAscending.value = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dữ liệu đã được sắp xếp theo thứ tự giảm dần'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class ChartData {
  final String number;
  final int count;

  ChartData(this.number, this.count);
}

class LineChartData {
  final int number;
  final int count;

  LineChartData(this.number, this.count);
}
