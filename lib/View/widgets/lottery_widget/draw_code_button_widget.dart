import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

Widget drawCodeWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      lotteryViewModel.showDrawCodes(context);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Kỳ số: ",
          style: TextStyle(
            fontSize: 23,
            // fontWeight: FontWeight.bold,
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
        GestureDetector(
          onTap: () {
            lotteryViewModel.showDrawCodes(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 238, 232, 232),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 7, 13, 92).withOpacity(0.5),
                  offset: const Offset(5, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              "${lotteryViewModel.lotteryModel.drawCode}",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
