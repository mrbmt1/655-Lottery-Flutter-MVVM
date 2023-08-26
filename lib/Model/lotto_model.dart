import 'package:get/get.dart';

class LotteryModel extends GetxController {
  final RxString drawDate = "".obs;
  final RxString drawCode = "".obs;
  final RxInt regularNumber1Controller = 0.obs;
  final RxInt regularNumber2Controller = 0.obs;
  final RxInt regularNumber3Controller = 0.obs;
  final RxInt regularNumber4Controller = 0.obs;
  final RxInt regularNumber5Controller = 0.obs;
  final RxInt regularNumber6Controller = 0.obs;
  final RxInt specialNumberController = 0.obs;
  final RxInt prize1Value = 0.obs;
  final RxInt prize2Value = 0.obs;
  final RxInt jackpot1Winner = 0.obs;
  final RxInt jackpot1Prize = 0.obs;
  final RxInt jackpot2Winner = 0.obs;
  final RxInt jackpot2Prize = 0.obs;
  final RxList<String> drawCodes = <String>[].obs;
  final RxList<String> drawDates = <String>[].obs;
  final RxList<String> jackpotWinningDraws = <String>[].obs;
  final RxList<String> jackpotWinningDrawDates = <String>[].obs;
  RxDouble containerOffset = 0.0.obs;
}
