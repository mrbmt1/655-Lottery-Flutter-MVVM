import 'package:get/get.dart';

class PredictionModel {
  RxList<String> topFrequentNumbers = <String>[].obs;
  RxList<String> topFrequentPairs = <String>[].obs;
  RxList<String> predictionNumbers = <String>[].obs;
  RxList<String> topFrequentTriplets = <String>[].obs;
  RxList<String> neverAppearedPairs = <String>[].obs;
  RxList<String> topFrequentQuadruplets = <String>[].obs;
  RxList<String> topFrequentQuintuplets = <String>[].obs;
  RxList<String> topFrequentSextuplets = <String>[].obs;

  RxBool viewTopFrequent = true.obs;
  RxBool viewPredictLinearRegression = true.obs;
  RxBool viewNeverAppearedPairs = true.obs;
  RxBool viewPairs = true.obs;
  RxBool viewTriplets = true.obs;
  RxBool viewQuadruplets = true.obs;
  RxBool viewQuintuplets = true.obs;
  RxBool viewSextuplets = true.obs;

  RxBool isSextupletsLoaded = false.obs;
  RxBool isQuadrupletsLoaded = false.obs;
  RxBool isQuintupletsLoaded = false.obs;
  RxBool allPairsAppeared = false.obs;
}
