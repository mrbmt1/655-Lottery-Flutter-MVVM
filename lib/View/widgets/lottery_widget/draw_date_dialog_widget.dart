import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawDateDialog extends StatelessWidget {
  final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());
  List<String> filteredDrawDates;
  final Function(String) onDrawDateSelected;

  DrawDateDialog({
    super.key,
    required this.filteredDrawDates,
    required this.onDrawDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 22, 25, 179),
                  Color.fromARGB(255, 172, 40, 16),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      "Chọn ngày",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      filteredDrawDates = lotteryViewModel
                          .lotteryModel.drawDates
                          .where((drawDate) => drawDate.contains(value))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm theo ngày',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredDrawDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      final drawDate = filteredDrawDates[index];
                      final isJackpotWinner = lotteryViewModel
                          .lotteryModel.jackpotWinningDrawDates
                          .contains(drawDate);
                      final textColor =
                          isJackpotWinner ? Colors.yellow : Colors.white;
                      final textShadow = isJackpotWinner
                          ? [
                              const Shadow(
                                color: Colors.yellow,
                                blurRadius: 12.0,
                                offset: Offset(0, 0),
                              ),
                            ]
                          : null;

                      return ListTile(
                        title: Text(
                          drawDate,
                          style:
                              TextStyle(color: textColor, shadows: textShadow),
                        ),
                        onTap: () async {
                          Navigator.of(context).pop();
                          await lotteryViewModel.loadDataForDrawDate(drawDate);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
