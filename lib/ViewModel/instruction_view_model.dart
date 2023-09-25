import 'package:do_so_655/Model/instruction_model.dart';
import 'package:get/get.dart';

class InstructionViewModel extends GetxController {
  final InstructionModel instructionModel = InstructionModel();

  void toggleLottoScreen() {
    instructionModel.hidelottoScreen.toggle();
    instructionModel.lottoScreen.toggle();
  }

  void toggleCheckingScreen() {
    instructionModel.hidecheckingScreen.toggle();
    instructionModel.checkingScreen.toggle();
  }

  void togglePredictionScreen() {
    instructionModel.hidepredictionScreen.toggle();
    instructionModel.predictionScreen.toggle();
  }

  void toggleChartScreen() {
    instructionModel.hidechartScreen.toggle();
    instructionModel.chartScreen.toggle();
  }

  void toggleCheckingAllScreen() {
    instructionModel.hidecheckingAllScreen.toggle();
    instructionModel.checkingAllScreen.toggle();
  }
}
