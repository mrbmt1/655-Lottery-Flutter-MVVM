import 'package:do_so_655/View/widgets/lottery_widget/number_widget.dart';
import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

Widget rowSevenNumberResult() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber1Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber2Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber3Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber4Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber5Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.regularNumber6Controller.value,
        gradientStartColor: Colors.orange,
        gradientEndColor: Colors.red,
        shadowColor: Colors.black,
      ),
      NumberWidget(
        number: lotteryViewModel.lotteryModel.specialNumberController.value,
        gradientStartColor: Color.fromARGB(255, 255, 0, 85),
        gradientEndColor: Colors.blueAccent,
        shadowColor: Colors.black,
      ),
    ],
  );
}
