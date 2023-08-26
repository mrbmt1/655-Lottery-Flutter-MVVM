import 'package:do_so_655/View/widgets/prediction_widget/prediction_menu_button_widget.dart';
import 'package:do_so_655/ViewModel/prediction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final PredictionViewModel predictionViewModel =
      Get.put(PredictionViewModel());

  // @override
  // void dispose() {
  //   predictionViewModel.clearData();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dự đoán 6/55'),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 22, 25, 179),
          actions: [
            PredictionMenuButton(predictionViewModel: predictionViewModel),
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
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
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewPredictLinearRegression.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Kết quả từ dự đoán hồi quy tuyến tính(giảm dần từ trái sang phải):',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  predictionViewModel.predictionModel
                                          .predictionNumbers.isNotEmpty
                                      ? predictionViewModel
                                          .predictionModel.predictionNumbers
                                          .join(' - ')
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .predictLinearRegression(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Dự đoán Hồi quy tuyến tính',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewTopFrequent.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewTopFrequent.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  '10 số có tần suất xuất hiện nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (predictionViewModel.predictionModel
                                    .topFrequentNumbers.isNotEmpty)
                                  const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: predictionViewModel.predictionModel
                                      .topFrequentNumbers.length,
                                  itemBuilder: (context, index) {
                                    final number = predictionViewModel
                                        .predictionModel
                                        .topFrequentNumbers[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Text(
                                        number,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentNumbers(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            predictionViewModel.predictionModel.viewPairs.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible:
                            predictionViewModel.predictionModel.viewPairs.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  '10 cặp số xuất hiện cùng nhau nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: predictionViewModel
                                      .predictionModel.topFrequentPairs.length,
                                  itemBuilder: (context, index) {
                                    final pair = predictionViewModel
                                        .predictionModel
                                        .topFrequentPairs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Text(
                                        pair,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentPairs(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewTriplets.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewTriplets.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'bộ 3 cặp số xuất hiện cùng nhau nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: predictionViewModel.predictionModel
                                      .topFrequentTriplets.length,
                                  itemBuilder: (context, index) {
                                    final triplet = predictionViewModel
                                        .predictionModel
                                        .topFrequentTriplets[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Text(
                                        triplet,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentTriplets(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewQuadruplets.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewQuadruplets.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'bộ 4 cặp số xuất hiện cùng nhau nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (predictionViewModel
                                    .predictionModel.isQuadrupletsLoaded.value)
                                  if (predictionViewModel.predictionModel
                                      .topFrequentQuadruplets.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: predictionViewModel
                                          .predictionModel
                                          .topFrequentQuadruplets
                                          .length,
                                      itemBuilder: (context, index) {
                                        final quadruplet = predictionViewModel
                                            .predictionModel
                                            .topFrequentQuadruplets[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Text(
                                            quadruplet,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      'Chưa có bộ 4 số nào xuất hiện cùng nhau ít nhất 2 lần',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                if (!predictionViewModel
                                    .predictionModel.isQuadrupletsLoaded.value)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentQuadruplets(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewQuintuplets.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewQuintuplets.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'bộ 5 cặp số xuất hiện cùng nhau nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (predictionViewModel
                                    .predictionModel.isQuintupletsLoaded.value)
                                  if (predictionViewModel.predictionModel
                                      .topFrequentQuintuplets.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: predictionViewModel
                                          .predictionModel
                                          .topFrequentQuintuplets
                                          .length,
                                      itemBuilder: (context, index) {
                                        final quintuplet = predictionViewModel
                                            .predictionModel
                                            .topFrequentQuintuplets[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Text(
                                            quintuplet,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      'Chưa có bộ 5 số nào xuất hiện cùng nhau ít nhất 2 lần',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                if (!predictionViewModel
                                    .predictionModel.isQuintupletsLoaded.value)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentQuintuplets(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewSextuplets.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewSextuplets.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'bộ 6 cặp số xuất hiện cùng nhau nhiều nhất:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (predictionViewModel
                                    .predictionModel.isSextupletsLoaded.value)
                                  if (predictionViewModel.predictionModel
                                      .topFrequentSextuplets.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: predictionViewModel
                                          .predictionModel
                                          .topFrequentSextuplets
                                          .length,
                                      itemBuilder: (context, index) {
                                        final sextuplet = predictionViewModel
                                            .predictionModel
                                            .topFrequentSextuplets[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Text(
                                            sextuplet,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Text(
                                      'Chưa có bộ 6 số nào xuất hiện ít nhất 2 lần',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                if (!predictionViewModel
                                    .predictionModel.isSextupletsLoaded.value)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listTopFrequentSextuplets(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewNeverAppearedPairs.value,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: predictionViewModel
                            .predictionModel.viewNeverAppearedPairs.value,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.white.withOpacity(0.01),
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Những bộ số chưa bao giờ xuất hiện cùng nhau:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (predictionViewModel
                                    .predictionModel.allPairsAppeared.value)
                                  const Text(
                                    'Tất cả các số đều đã xuất hiện cùng nhau',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                else
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: predictionViewModel
                                        .predictionModel
                                        .neverAppearedPairs
                                        .length,
                                    itemBuilder: (context, index) {
                                      final pair = predictionViewModel
                                          .predictionModel
                                          .neverAppearedPairs[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: Text(
                                          pair,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    predictionViewModel
                                        .listNeverAppearedPairs(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 0,
                                    primary: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
