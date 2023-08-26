import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

Widget jackpot2PrizeWidget(BuildContext context) {
  return GestureDetector(
    onHorizontalDragEnd: (details) async {
      await lotteryViewModel.handleHorizontalDragEnd(
          details, context, lotteryViewModel);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
          left: lotteryViewModel.lotteryModel.containerOffset.value,
          right: -(lotteryViewModel.lotteryModel.containerOffset.value)),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 238, 232, 232),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
        color: lotteryViewModel.lotteryModel.jackpot2Winner > 0
            ? Colors.transparent
            : null,
        boxShadow: lotteryViewModel.lotteryModel.jackpot2Winner > 0
            ? [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.5),
                  spreadRadius: 15,
                  blurRadius: 35,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(
            "Trị giá Jackpot 2: ",
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 238, 232, 232),
              shadows: [
                Shadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          Text(
            "${(lotteryViewModel.lotteryModel.prize2Value).toStringAsFixed(0).replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (match) => '${match[1]}.',
                ).toString()} VNĐ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 238, 232, 232),
              shadows: [
                Shadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
