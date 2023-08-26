import 'package:do_so_655/ViewModel/checking_all_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CheckingAllViewModel checkingAllViewModel =
    Get.put(CheckingAllViewModel());

Widget detaiResultsWidget() {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: checkingAllViewModel.checkingAllModel.lotteryResults.length,
        itemBuilder: (context, index) {
          var result =
              checkingAllViewModel.checkingAllModel.lotteryResults[index];
          return Column(
            children: [
              if ((checkingAllViewModel.checkingAllModel.viewTriplets.value &&
                      checkingAllViewModel.getMatchingNumbersCount(result) >=
                          3) ||
                  (checkingAllViewModel
                          .checkingAllModel.viewQuadruplets.value &&
                      checkingAllViewModel.getMatchingNumbersCount(result) >=
                          4) ||
                  (checkingAllViewModel
                          .checkingAllModel.viewQuintuplets.value &&
                      checkingAllViewModel
                              .getMatchingNumbersCount(result) >=
                          5) ||
                  (checkingAllViewModel.checkingAllModel.viewSextuplets.value &&
                      checkingAllViewModel.getMatchingNumbersCount(result) >=
                          6) ||
                  checkingAllViewModel.checkingAllModel.viewAllResults.value)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 3),
                      child: Row(
                        children: [
                          const Text(
                            'Kỳ: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${result['drawPeriod']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Ngày: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${result['drawDate']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(''),
                        for (var number in result['winningNumbers'])
                          GestureDetector(
                            onTap: () {
                              checkingAllViewModel.showResultDetails(
                                  result['drawPeriod'], context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: checkingAllViewModel
                                            .isNumberMatching(number)
                                        ? Colors.green
                                        : Colors.white,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$number',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (result['specialNumber'] != null)
                          GestureDetector(
                            onTap: () {
                              checkingAllViewModel.showResultDetails(
                                  result['drawPeriod'], context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        checkingAllViewModel.isNumberMatching(
                                                result['specialNumber'])
                                            ? Colors.green
                                            : Colors.redAccent,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${result['specialNumber']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    ],
  );
}
