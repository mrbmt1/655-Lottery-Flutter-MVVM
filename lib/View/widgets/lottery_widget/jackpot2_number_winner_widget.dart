import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

Widget numberWinnerJackpot2() {
  return Column(
    children: [
      Text(
        "Jackpot 2:",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lotteryViewModel.lotteryModel.jackpot2Winner > 0
              ? Colors.yellow // Đổi màu nếu có người trúng
              : const Color.fromARGB(255, 238, 232, 232),
          shadows: [
            BoxShadow(
              color: Colors.yellow.withOpacity(0.5),
              spreadRadius: 15,
              blurRadius: 35,
              offset: const Offset(
                  0, 3), // thêm hiệu ứng chói sáng nếu jackpot1Winner > 0
            ),
          ],
        ),
      ),
      const SizedBox(height: 5),
      Text(
        "Số người trúng: ${lotteryViewModel.lotteryModel.jackpot2Winner}",
        style: TextStyle(
          fontSize: 20,
          color: lotteryViewModel.lotteryModel.jackpot2Winner > 0
              ? Colors.yellow // Đổi màu nếu có người trúng
              : const Color.fromARGB(255, 238, 232, 232),
          shadows: [
            BoxShadow(
              color: Colors.yellow.withOpacity(0.5),
              spreadRadius: 15,
              blurRadius: 35,
              offset: const Offset(
                  0, 3), // thêm hiệu ứng chói sáng nếu jackpot1Winner > 0
            )
          ],
        ),
      ),
      Text(
        "${(lotteryViewModel.lotteryModel.jackpot2Prize).toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (match) => '${match[1]}.',
            ).toString()} VNĐ",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lotteryViewModel.lotteryModel.jackpot2Winner > 0
              ? Colors.yellow // Đổi màu nếu có người trúng
              : const Color.fromARGB(255, 238, 232, 232),
          shadows: [
            BoxShadow(
              color: Colors.yellow.withOpacity(0.5),
              spreadRadius: 15,
              blurRadius: 35,
              offset: const Offset(
                  0, 3), // thêm hiệu ứng chói sáng nếu jackpot1Winner > 0
            )
          ],
        ),
      ),
    ],
  );
}
