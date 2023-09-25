import 'package:do_so_655/ViewModel/chart_view_model.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final ChartViewModel chartViewModel = Get.put(ChartViewModel());

  @override
  void initState() {
    super.initState();
    internetChecking(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Thống kê 6/55'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'column_chart':
                  chartViewModel.toggleViewColumnChart();
                  break;
                case 'line_chart':
                  chartViewModel.toggleViewLineChart();
                  break;
                case 'frequency_list':
                  chartViewModel.toggleView55();
                  break;
                case 'winning_statistics':
                  chartViewModel.toggleViewWinner();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'column_chart',
                child: Text('Hiển thị biểu đồ cột'),
              ),
              const PopupMenuItem<String>(
                value: 'line_chart',
                child: Text('Hiển thị biểu đồ đường'),
              ),
              const PopupMenuItem<String>(
                value: 'frequency_list',
                child: Text('Hiển thị danh sách tần suất'),
              ),
              const PopupMenuItem<String>(
                value: 'winning_statistics',
                child: Text('Hiển thị thông số trúng thưởng'),
              ),
            ],
          )
        ],
      ),
      body: Obx(
        () => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 22, 25, 179),
                Color.fromARGB(255, 172, 40, 16),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: chartViewModel.chartModel.formKey.value,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: chartViewModel.chartModel.startController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Kỳ bắt đầu',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập kỳ bắt đầu';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Vui lòng nhập số nguyên';
                          }
                          if (chartViewModel
                                  .chartModel.endController.text.isNotEmpty &&
                              int.tryParse(value)! >
                                  int.tryParse(chartViewModel
                                      .chartModel.endController.text)!) {
                            return 'Kỳ bắt đầu phải nhỏ hơn hoặc bằng kỳ kết thúc';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: chartViewModel.chartModel.endController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Kỳ kết thúc',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vui lòng nhập kỳ kết thúc';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Vui lòng nhập số nguyên';
                          }
                          if (chartViewModel
                                  .chartModel.startController.text.isNotEmpty &&
                              int.tryParse(value)! <
                                  int.tryParse(chartViewModel
                                      .chartModel.startController.text)!) {
                            return 'Kỳ kết thúc phải lớn hơn hoặc bằng kỳ bắt đầu';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        bool hasConnectivity = await ConnectivityUtils
                            .checkConnectivityForFunction(context);
                        if (!hasConnectivity) {
                          return;
                        }
                        if (chartViewModel
                            .chartModel.formKey.value.currentState!
                            .validate()) {
                          chartViewModel.chartModel.startCode.value =
                              int.tryParse(chartViewModel
                                  .chartModel.startController.text);
                          chartViewModel.chartModel.endCode.value =
                              int.tryParse(
                                  chartViewModel.chartModel.endController.text);
                          chartViewModel.getData(
                              chartViewModel.chartModel.startCode.value!,
                              chartViewModel.chartModel.endCode.value!);
                        }
                      },
                      child: const Text('Thống kê'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Visibility(
                    visible:
                        chartViewModel.chartModel.viewColumnChart.value == true,
                    child: Expanded(
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(0),
                          child: charts.BarChart(
                            chartViewModel.createSampleData(),
                            animate: true,
                            domainAxis: const charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(
                                labelStyle: charts.TextStyleSpec(
                                  fontSize: 5,
                                  color: charts.MaterialPalette.white,
                                ),
                                labelRotation: 0,
                                labelAnchor: charts.TickLabelAnchor.centered,
                              ),
                            ),
                            primaryMeasureAxis: const charts.NumericAxisSpec(
                              renderSpec: charts.GridlineRendererSpec(
                                lineStyle: charts.LineStyleSpec(
                                  dashPattern: [4],
                                  color: charts.MaterialPalette.white,
                                ),
                              ),
                            ),
                            defaultInteractions: true,
                            selectionModels: [
                              charts.SelectionModelConfig(
                                type: charts.SelectionModelType.info,
                                changedListener: onSelectionChanged,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        chartViewModel.chartModel.viewColumnChart.value == true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_downward,
                              color: Colors.white),
                          onPressed: () {
                            chartViewModel.sortColumnChartDescending(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded,
                              color: Colors.white),
                          onPressed: () {
                            chartViewModel.sortColumnChartAscending(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible:
                    chartViewModel.chartModel.viewColumnChart.value == true,
                child: Text(
                    'Biểu đồ cột thống kê từ kỳ ${chartViewModel.chartModel.startCode.value} đến kỳ  ${chartViewModel.chartModel.startCode.value! + (chartViewModel.numOfDrawPeriods - 1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16),
              Visibility(
                visible: chartViewModel.chartModel.viewLineChart.value == true,
                child: Expanded(
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(0),
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(0),
                      child: charts.LineChart(
                        chartViewModel.createSampleLineChartData(),
                        animate: true,
                        domainAxis: const charts.NumericAxisSpec(
                          renderSpec: charts.SmallTickRendererSpec(
                            labelStyle: charts.TextStyleSpec(
                              fontSize: 5,
                            ),
                            labelRotation: 0,
                            labelAnchor: charts.TickLabelAnchor.centered,
                          ),
                        ),
                        primaryMeasureAxis: const charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(
                            lineStyle: charts.LineStyleSpec(
                              dashPattern: [4],
                            ),
                          ),
                        ),
                        defaultInteractions: true,
                        selectionModels: [
                          charts.SelectionModelConfig(
                            type: charts.SelectionModelType.info,
                            changedListener: onSelectionChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: chartViewModel.chartModel.viewLineChart.value == true,
                child: Text(
                    'Biểu đồ đường thống kê từ kỳ ${chartViewModel.chartModel.startCode.value} đến kỳ  ${chartViewModel.chartModel.startCode.value! + (chartViewModel.numOfDrawPeriods - 1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: chartViewModel.chartModel.view55.value == true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        chartViewModel.chartModel.sortAscending.value = true;
                        chartViewModel.sortFrequency();
                        ScaffoldMessenger.of(context)
                            .removeCurrentSnackBar(); // Đóng Snackbar hiện tại (nếu có)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Đã sắp xếp danh sách theo thứ tự tăng dần'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child:
                          const Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        chartViewModel.chartModel.sortAscending.value = false;
                        chartViewModel.sortFrequency();
                        ScaffoldMessenger.of(context)
                            .removeCurrentSnackBar(); // Đóng Snackbar hiện tại (nếu có)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Đã sắp xếp danh sách theo tần suất giảm dần'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child:
                          const Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: chartViewModel.chartModel.view55.value == true,
                child: Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        if (chartViewModel.chartModel.view55.value)
                          for (var entry
                              in chartViewModel.chartModel.frequency.entries)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${entry.key}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${entry.value} lần',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: chartViewModel.chartModel.winner.value == true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Số người trúng jackpot 1: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${chartViewModel.chartModel.jackpot1_winner}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Tổng tiền trúng jackpot 1: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                            child: Text(
                          '${NumberFormat('#,###', 'vi').format(chartViewModel.chartModel.jackpot1_prize.value)} VNĐ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Số người trúng jackpot 2: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${chartViewModel.chartModel.jackpot2_winner.value}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Tổng tiền trúng jackpot 2: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                            child: Text(
                          '${NumberFormat('#,###', 'vi').format(chartViewModel.chartModel.jackpot2_prize.value)} VNĐ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelectionChanged(charts.SelectionModel model) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (model.hasDatumSelection) {
      final selectedDatum = model.selectedDatum.first;
      final snackBar = SnackBar(
        content: Text(
          'Số ${selectedDatum.datum.number}: ${selectedDatum.datum.count} lần',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
