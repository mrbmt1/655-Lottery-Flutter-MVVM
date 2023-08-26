import 'package:do_so_655/Model/prediction_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:ml_linalg/linalg.dart';

class PredictionViewModel extends GetxController {
  final PredictionModel predictionModel = PredictionModel();

  void toggleViewTopFrequentVisibility() {
    predictionModel.viewTopFrequent.toggle();
  }

  void toggleViewPredictLinearRegressionVisibility() {
    predictionModel.viewPredictLinearRegression.toggle();
  }

  void toggleViewNeverAppearedPairsVisibility() {
    predictionModel.viewNeverAppearedPairs.toggle();
  }

  void toggleViewPairsVisibility() {
    predictionModel.viewPairs.toggle();
  }

  void toggleViewTripletsVisibility() {
    predictionModel.viewTriplets.toggle();
  }

  void toggleViewQuadrupletsVisibility() {
    predictionModel.viewQuadruplets.toggle();
  }

  void toggleViewQuintupletsVisibility() {
    predictionModel.viewQuintuplets.toggle();
  }

  void toggleViewSextupletsVisibility() {
    predictionModel.viewSextuplets.toggle();
  }

  Future listTopFrequentNumbers(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final numberCounts = Map<int, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      numbers.forEach((number) {
        numberCounts.update(number, (value) => value + 1, ifAbsent: () => 1);
      });
    });

    final sortedNumbers = numberCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentNumbers = sortedNumbers
        .take(10)
        .map((entry) =>
            '${entry.key} (${entry.value} lần / $totalCount kỳ ~ ${((entry.value / totalCount) * 100).toStringAsFixed(2)}%/kỳ)')
        .toList();

    predictionModel.topFrequentNumbers.assignAll(topFrequentNumbers);
  }

  void predictLinearRegression(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final data = snapshot.docs.map((doc) {
      final numbers = [
        doc['number_1'] as num,
        doc['number_2'] as num,
        doc['number_3'] as num,
        doc['number_4'] as num,
        doc['number_5'] as num,
        doc['number_6'] as num,
        doc['special_number'] as num
      ];

      final input = Vector.fromList(
          numbers.sublist(0, 6).map((num) => num.toDouble()).toList());
      final output = Vector.fromList(
          [numbers.last.toDouble()]); // Chỉ lấy giá trị cuối cùng làm output

      return [input, output];
    }).toList();

    final inputs = Matrix.fromRows(data.map((row) => row[0]).toList());
    final outputs = Matrix.fromColumns(data.map((row) => row[1]).toList());

    final transposedInputs = inputs.transpose();
    final transposedOutputs = outputs.transpose();

    final coefficientMatrix = (transposedInputs * inputs).inverse() *
        transposedInputs *
        transposedOutputs;

    final predictions = inputs * coefficientMatrix;

    // Sắp xếp các số dự đoán theo thứ tự giảm dần
    final sortedPredictions = predictions.getColumn(0).toList();

    final distinctPredictions = <int>[];
    for (final prediction in sortedPredictions) {
      final predictionInt = prediction.toInt();
      if (!distinctPredictions.contains(predictionInt)) {
        distinctPredictions.add(predictionInt);
        if (distinctPredictions.length == 6) {
          break;
        }
      }
    }

    predictionModel.predictionNumbers
        .assignAll(distinctPredictions.map((num) => num.toString()).toList());
  }

  void listTopFrequentPairs(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final pairCounts = Map<String, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      final pairs = List.generate(numbers.length - 1, (index) {
        final firstNumber = numbers[index];
        final secondNumber = numbers[index + 1];
        return '${firstNumber}_$secondNumber';
      });

      for (var pair in pairs) {
        pairCounts.update(pair, (value) => value + 1, ifAbsent: () => 1);
      }
    });

    final sortedPairs = pairCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentPairs = sortedPairs
        .take(10)
        .map((entry) =>
            '${entry.key.replaceAll('_', ' và ')} ( ${entry.value} lần/$totalCount kỳ )')
        .toList();

    predictionModel.topFrequentPairs.assignAll(topFrequentPairs);
  }

  void listTopFrequentTriplets(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final tripletCounts = Map<String, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      final triplets = List.generate(numbers.length - 2, (index) {
        final firstNumber = numbers[index];
        final secondNumber = numbers[index + 1];
        final thirdNumber = numbers[index + 2];
        return '${firstNumber}_${secondNumber}_$thirdNumber';
      });

      triplets.forEach((triplet) {
        tripletCounts.update(triplet, (value) => value + 1, ifAbsent: () => 1);
      });
    });

    final sortedTriplets = tripletCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentTriplets = sortedTriplets
        .take(10)
        .map((entry) =>
            '${entry.key.replaceAll('_', ', ')} ( ${entry.value} lần/$totalCount kỳ )')
        .toList();

    predictionModel.topFrequentTriplets.assignAll(topFrequentTriplets);
  }

  void listTopFrequentQuadruplets(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final quadrupletCounts = Map<String, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      final quadruplets = List.generate(numbers.length - 3, (index) {
        final firstNumber = numbers[index];
        final secondNumber = numbers[index + 1];
        final thirdNumber = numbers[index + 2];
        final fourthNumber = numbers[index + 3];
        return '${firstNumber}_${secondNumber}_${thirdNumber}_$fourthNumber';
      });

      quadruplets.forEach((quadruplet) {
        quadrupletCounts.update(quadruplet, (value) => value + 1,
            ifAbsent: () => 1);
      });
    });

    final sortedQuadruplets = quadrupletCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentQuadruplets = sortedQuadruplets
        .where((entry) => entry.value >= 2)
        .take(20)
        .map((entry) =>
            '${entry.key.replaceAll('_', ', ')} ( ${entry.value} lần/$totalCount kỳ )')
        .toList();

    predictionModel.topFrequentQuadruplets.assignAll(topFrequentQuadruplets);
    predictionModel.isQuadrupletsLoaded.value = true;
  }

  void listTopFrequentQuintuplets(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final quintupletCounts = Map<String, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      final quintuplets = List.generate(numbers.length - 4, (index) {
        final firstNumber = numbers[index];
        final secondNumber = numbers[index + 1];
        final thirdNumber = numbers[index + 2];
        final fourthNumber = numbers[index + 3];
        final fifthNumber = numbers[index + 4];
        return '${firstNumber}_${secondNumber}_${thirdNumber}_${fourthNumber}_${fifthNumber}';
      });

      quintuplets.forEach((quintuplet) {
        quintupletCounts.update(quintuplet, (value) => value + 1,
            ifAbsent: () => 1);
      });
    });

    final sortedQuintuplets = quintupletCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentQuintuplets = sortedQuintuplets
        .where((entry) => entry.value >= 2)
        .take(20)
        .map((entry) =>
            '${entry.key.replaceAll('_', ', ')} ( ${entry.value} lần/$totalCount kỳ )')
        .toList();

    predictionModel.topFrequentQuintuplets.assignAll(topFrequentQuintuplets);
    predictionModel.isQuintupletsLoaded.value = true;
  }

  void listTopFrequentSextuplets(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: true)
        .get();

    final sextupletCounts = Map<String, int>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      final sextuplets = List.generate(numbers.length - 5, (index) {
        final firstNumber = numbers[index];
        final secondNumber = numbers[index + 1];
        final thirdNumber = numbers[index + 2];
        final fourthNumber = numbers[index + 3];
        final fifthNumber = numbers[index + 4];
        final sixthNumber = numbers[index + 5];
        return '${firstNumber}_${secondNumber}_${thirdNumber}_${fourthNumber}_${fifthNumber}_${sixthNumber}';
      });

      sextuplets.forEach((sextuplet) {
        sextupletCounts.update(sextuplet, (value) => value + 1,
            ifAbsent: () => 1);
      });
    });

    final sortedSextuplets = sextupletCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalCount = snapshot.size;

    final topFrequentSextuplets = sortedSextuplets
        .where((entry) => entry.value >= 2)
        .take(20)
        .map((entry) =>
            '${entry.key.replaceAll('_', ', ')} ( ${entry.value} lần/$totalCount kỳ )')
        .toList();

    predictionModel.topFrequentSextuplets.assignAll(topFrequentSextuplets);
    predictionModel.isSextupletsLoaded.value = true;
  }

  void listNeverAppearedPairs(BuildContext context) async {
    internetChecking(context);

    final snapshot = await FirebaseFirestore.instance
        .collection('vietlott_655_results')
        .orderBy('draw_period', descending: false)
        .get();

    final appearedPairs = Set<String>();

    snapshot.docs.forEach((doc) {
      final numbers = [
        doc['number_1'] as int,
        doc['number_2'] as int,
        doc['number_3'] as int,
        doc['number_4'] as int,
        doc['number_5'] as int,
        doc['number_6'] as int,
        doc['special_number'] as int,
      ];

      for (int i = 0; i < numbers.length - 1; i++) {
        for (int j = i + 1; j < numbers.length; j++) {
          final pair1 = '${numbers[i]}_${numbers[j]}';
          final pair2 = '${numbers[j]}_${numbers[i]}';

          appearedPairs.add(pair1);
          appearedPairs.add(pair2);
        }
      }
    });

    final neverAppearedPairs = <String>[];
    const totalCount = 55 * 54 ~/ 2;

    for (int i = 1; i <= 55; i++) {
      for (int j = i + 1; j <= 55; j++) {
        final pair = '${i}_$j';

        if (!appearedPairs.contains(pair)) {
          neverAppearedPairs.add(pair);
        }
      }
    }

    if (neverAppearedPairs.isEmpty) {
      predictionModel.allPairsAppeared.value = true;
    } else {
      predictionModel.neverAppearedPairs.assignAll(neverAppearedPairs);
    }
  }

  // void clearData() {
  //   predictionModel.topFrequentNumbers.clear();
  //   predictionModel.viewTopFrequent.value = true;
  // }
}
