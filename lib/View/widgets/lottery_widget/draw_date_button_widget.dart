import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

Widget drawDateWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      lotteryViewModel.showDrawDates(context);
    },
    child: Column(
      children: [
        Text(
          "Ngày mở thưởng:",
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
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 238, 232, 232),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 7, 13, 92).withOpacity(0.5),
                offset: const Offset(6, 5),
                blurRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            " ${lotteryViewModel.lotteryModel.drawDate}",
            style: TextStyle(
              fontSize: 22,
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
        ),
      ],
    ),
  );
}
