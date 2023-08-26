import 'package:do_so_655/ViewModel/checking_all_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  final CheckingAllViewModel checkingAllViewModel;

  const PopupMenuButtonWidget({super.key, required this.checkingAllViewModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckingAllViewModel>(
      builder: (controller) {
        return PopupMenuButton<String>(
          onSelected: (value) {
            checkingAllViewModel.checkingAllModel.viewTriplets.value = false;
            checkingAllViewModel.checkingAllModel.viewQuadruplets.value = false;
            checkingAllViewModel.checkingAllModel.viewQuintuplets.value = false;
            checkingAllViewModel.checkingAllModel.viewSextuplets.value = false;
            checkingAllViewModel.checkingAllModel.viewAllResults.value = false;
            switch (value) {
              case 'viewTriplets':
                checkingAllViewModel.checkingAllModel.viewTriplets.value = true;
                break;
              case 'viewQuadruplets':
                checkingAllViewModel.checkingAllModel.viewQuadruplets.value =
                    true;
                break;
              case 'viewQuintuplets':
                checkingAllViewModel.checkingAllModel.viewQuintuplets.value =
                    true;
                break;
              case 'viewSextuplets':
                checkingAllViewModel.checkingAllModel.viewSextuplets.value =
                    true;
                break;
              case 'viewAllResults':
                checkingAllViewModel.checkingAllModel.viewAllResults.value =
                    true;
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'viewTriplets',
              child: Text('Hiển thị kết quả trùng ít nhất 3 cặp số'),
            ),
            const PopupMenuItem<String>(
              value: 'viewQuadruplets',
              child: Text('Hiển thị kết quả trùng ít nhất 4 cặp số'),
            ),
            const PopupMenuItem<String>(
              value: 'viewQuintuplets',
              child: Text('Hiển thị kết quả trùng ít nhất 5 cặp số'),
            ),
            const PopupMenuItem<String>(
              value: 'viewSextuplets',
              child: Text('Hiển thị kết quả trùng ít nhất 6 cặp số'),
            ),
            const PopupMenuItem<String>(
              value: 'viewAllResults',
              child: Text('Hiển thị tất cả kết quả'),
            ),
          ],
        );
      },
    );
  }
}
