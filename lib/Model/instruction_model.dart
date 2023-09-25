import 'package:get/get.dart';

class InstructionModel {
  RxBool lottoScreen = false.obs;
  RxBool checkingScreen = false.obs;
  RxBool chartScreen = false.obs;
  RxBool predictionScreen = false.obs;
  RxBool checkingAllScreen = false.obs;

  RxBool hidelottoScreen = true.obs;
  RxBool hidecheckingScreen = true.obs;
  RxBool hidechartScreen = true.obs;
  RxBool hidepredictionScreen = true.obs;
  RxBool hidecheckingAllScreen = true.obs;
}
