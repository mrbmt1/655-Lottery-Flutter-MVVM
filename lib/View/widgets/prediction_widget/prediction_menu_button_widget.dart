import 'package:do_so_655/View/screens/checking_all_screen.dart';
import 'package:do_so_655/ViewModel/prediction_view_model.dart';
import 'package:flutter/material.dart';

class PredictionMenuButton extends StatelessWidget {
  final PredictionViewModel predictionViewModel;

  const PredictionMenuButton({super.key, required this.predictionViewModel});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'viewPredictLinearRegression':
            predictionViewModel.toggleViewPredictLinearRegressionVisibility();
            break;
          case 'viewTopFrequent':
            predictionViewModel.toggleViewTopFrequentVisibility();
            break;
          case 'viewPairs':
            predictionViewModel.toggleViewPairsVisibility();
            break;
          case 'viewTriplets':
            predictionViewModel.toggleViewTripletsVisibility();
            break;
          case 'viewQuadruplets':
            predictionViewModel.toggleViewQuadrupletsVisibility();
            break;
          case 'viewQuintuplets':
            predictionViewModel.toggleViewQuintupletsVisibility();
            break;
          case 'viewSextuplets':
            predictionViewModel.toggleViewSextupletsVisibility();
            break;
          case 'viewNeverAppearedPairs':
            predictionViewModel.toggleViewNeverAppearedPairsVisibility();
            break;
          case 'checkingAll':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CheckingAllScreen()),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'viewPredictLinearRegression',
          child: Text('Ẩn/hiện kết quả hồi quy tuyến tính'),
        ),
        const PopupMenuItem<String>(
          value: 'viewTopFrequent',
          child: Text('Ẩn/hiện 10 số tần suất cao nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewPairs',
          child: Text('Ẩn/hiển 10 bộ 2 số xuất hiện nhiều nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewTriplets',
          child: Text('Ẩn/hiển 10 bộ 3 số xuất hiện nhiều nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewQuadruplets',
          child: Text('Ẩn/hiển các bộ 4 số xuất hiện nhiều nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewQuintuplets',
          child: Text('Ẩn/hiển các 5 số xuất hiện nhiều nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewSextuplets',
          child: Text('Ẩn/hiển các bộ 6 số xuất hiện nhiều nhất'),
        ),
        const PopupMenuItem<String>(
          value: 'viewNeverAppearedPairs',
          child: Text('Ẩn/hiển bộ 2 chưa số xuất hiện cùng nhau'),
        ),
        const PopupMenuItem<String>(
          value: 'checkingAll',
          child: Text('Chuyển đến màn hình dò tất cả các kỳ'),
        ),
      ],
    );
  }
}
