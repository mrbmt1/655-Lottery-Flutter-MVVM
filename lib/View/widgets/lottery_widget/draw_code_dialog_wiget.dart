import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DrawCodeDialog extends StatelessWidget {
  final LotteryViewModel lotteryViewModel = Get.find<LotteryViewModel>();

  List<String> filteredDrawCodes;
  final Function(String) onDrawCodeSelected;

  DrawCodeDialog({
    super.key,
    required this.filteredDrawCodes,
    required this.onDrawCodeSelected,
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
                      "Chọn kỳ",
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
                    filteredDrawCodes = lotteryViewModel.lotteryModel.drawCodes
                        .where((drawCode) => drawCode.contains(value))
                        .toList();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm theo kỳ',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredDrawCodes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final drawCode = filteredDrawCodes[index];
                      final isJackpotWinner = lotteryViewModel
                          .lotteryModel.jackpotWinningDraws
                          .contains(drawCode);
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

                      return GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          await lotteryViewModel.loadDataForDraw(drawCode);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: ListTile(
                            title: Text(
                              drawCode,
                              style: TextStyle(
                                color: textColor,
                                shadows: textShadow,
                              ),
                            ),
                          ),
                        ),
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
