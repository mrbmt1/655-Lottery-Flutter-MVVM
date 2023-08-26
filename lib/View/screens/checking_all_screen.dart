import 'package:do_so_655/View/widgets/checking_all_widget/Popup_menu_widget.dart';
import 'package:do_so_655/View/widgets/checking_all_widget/detail_results_checking_all_widget.dart';
import 'package:do_so_655/View/widgets/checking_all_widget/number_input_filed_widget.dart';
import 'package:do_so_655/ViewModel/checking_all_view_model.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckingAllScreen extends StatefulWidget {
  @override
  _CheckingAllScreenState createState() => _CheckingAllScreenState();
}

class _CheckingAllScreenState extends State<CheckingAllScreen> {
  final CheckingAllViewModel checkingAllViewModel =
      Get.put(CheckingAllViewModel());

  @override
  void initState() {
    super.initState();
    internetChecking(context);
    checkingAllViewModel.clearCheckingAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dò tất cả số 6/55'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
        actions: [
          PopupMenuButtonWidget(checkingAllViewModel: checkingAllViewModel),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 22, 25, 179),
              Color.fromARGB(255, 172, 40, 16),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Số của bạn chọn:',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          checkingAllViewModel.clearNumbers();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.white.withOpacity(0.38),
                          disabledBackgroundColor:
                              Colors.white.withOpacity(0.12),
                          side: const BorderSide(width: 1, color: Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            'Xóa hết số',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Form(
                    key: checkingAllViewModel.checkingAllModel.formKey,
                    child: Row(
                      children: [
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController1,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number1BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode1,
                          nextFocusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode2,
                        ),
                        const SizedBox(width: 2),
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController2,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number2BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode2,
                          nextFocusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode3,
                        ),
                        const SizedBox(width: 2),
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController3,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number3BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode3,
                          nextFocusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode4,
                        ),
                        const SizedBox(width: 2),
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController4,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number4BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode4,
                          nextFocusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode5,
                        ),
                        const SizedBox(width: 2),
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController5,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number5BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode5,
                          nextFocusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode6,
                        ),
                        const SizedBox(width: 2),
                        NumberInputWidget(
                          controller: checkingAllViewModel
                              .checkingAllModel.numberController6,
                          borderColor: checkingAllViewModel
                              .checkingAllModel.number6BorderColor.value,
                          focusNode: checkingAllViewModel
                              .checkingAllModel.numberFocusNode6,
                          nextFocusNode: null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Visibility(
                child: ElevatedButton(
                  onPressed: () async {
                    checkingAllViewModel.checkingAllSubmit(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledForegroundColor: Colors.white.withOpacity(0.38),
                    disabledBackgroundColor: Colors.white.withOpacity(0.12),
                    side: const BorderSide(width: 1, color: Colors.white),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      'Dò số',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                child: Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: checkingAllViewModel
                              .checkingAllModel.isLoading.value,
                          child: const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 8),
                              Text(
                                'Dữ liệu rất lớn, đang tải dữ liệu...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (checkingAllViewModel
                            .checkingAllModel.showResult.value)
                          detaiResultsWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
