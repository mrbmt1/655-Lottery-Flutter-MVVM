import 'package:do_so_655/View/widgets/checking_widget/number_input_field.dart';
import 'package:do_so_655/View/widgets/checking_widget/number_result_row_widget.dart';
import 'package:do_so_655/ViewModel/checking_view_model.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'checking_all_screen.dart';

class CheckingScreen extends StatefulWidget {
  const CheckingScreen({super.key});

  @override
  _CheckingScreenState createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {
  final CheckingViewModel checkingViewModel = Get.put(CheckingViewModel());

  @override
  void initState() {
    super.initState();
    checkingViewModel.getDrawPeriods();
    internetChecking(context);
    checkingViewModel.clearDataChecking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Dò số 6/55'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'checkingAll') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => CheckingAllScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'checkingAll',
                child: Text('Chuyển đến màn hình dò tất cả'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() => Container(
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: checkingViewModel.formKey,
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          child: Image.asset(
                            'assets/images/Power655.png',
                            width: 150.0,
                            height: 150.0,
                          ),
                        ),
                        Visibility(
                          visible:
                              checkingViewModel.checkingModel.showResult.value,
                          child: Column(children: [
                            Text(
                              'Kết quả kỳ ${checkingViewModel.checkingModel.drawCodes}, ${checkingViewModel.checkingModel.drawDates}:',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController1result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number1resultBorderColor.value,
                                ),
                                const SizedBox(width: 2),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController2result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number2resultBorderColor.value,
                                ),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController3result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number3resultBorderColor.value,
                                ),
                                const SizedBox(width: 2),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController4result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number4resultBorderColor.value,
                                ),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController5result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number5resultBorderColor.value,
                                ),
                                const SizedBox(width: 2),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberController6result.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .number6resultBorderColor.value,
                                ),
                                NumberResultRow(
                                  result: checkingViewModel.checkingModel
                                      .numberControllerspecialresult.value,
                                  borderColor: checkingViewModel.checkingModel
                                      .numberspecialresultBorderColor.value,
                                ),
                                const SizedBox(width: 2),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              visible: checkingViewModel
                                  .checkingModel.showResultJackpot1.value,
                              child: Text(
                                'Chúc mừng bạn đã trúng giải Jackpot1: \n${(checkingViewModel.checkingModel.jackpot1prize.value).toStringAsFixed(0).replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (match) => '${match[1]}.',
                                    ).toString()} VNĐ',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 30, 255, 49),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: (TextAlign.center),
                              ),
                            ), //jackpot1
                            Visibility(
                              visible: checkingViewModel
                                  .checkingModel.showResultJackpot2.value,
                              child: Text(
                                'Chúc mừng bạn đã trúng giải Jackpot2: \n${(checkingViewModel.checkingModel.jackpot2prize.value).toStringAsFixed(0).replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (match) => '${match[1]}.',
                                    ).toString()} VNĐ',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 30, 255, 49),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: (TextAlign.center),
                              ),
                            ), //jackpot2
                            Visibility(
                              visible: checkingViewModel
                                  .checkingModel.showResult1st.value,
                              child: const Text(
                                'Chúc mừng bạn đã trúng giải Nhất \n40.000.000 đồng',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 255, 49),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: (TextAlign.center),
                              ),
                            ),
                            Visibility(
                              visible: checkingViewModel
                                  .checkingModel.showResult2nd.value,
                              child: const Text(
                                'Chúc mừng bạn đã trúng giải Nhì \n500.000 đồng',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 255, 49),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: (TextAlign.center),
                              ),
                            ),
                            Visibility(
                              visible: checkingViewModel
                                  .checkingModel.showResult3rd.value,
                              child: const Text(
                                'Chúc mừng bạn đã trúng giải Ba \n50.000 đồng',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 30, 255, 49),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: (TextAlign.center),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                    checkingViewModel.clearNumbers();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // màu nền trong suốt
                                    onSurface: Colors
                                        .white, // màu chữ khi không được nhấn
                                    side: const BorderSide(
                                        width: 1, color: Colors.white),
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
                          ]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController1,
                              borderColor: checkingViewModel
                                  .checkingModel.number1BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode1,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.numberFocusNode2,
                            ),
                            const SizedBox(width: 2),
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController2,
                              borderColor: checkingViewModel
                                  .checkingModel.number2BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode2,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.numberFocusNode3,
                            ),
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController3,
                              borderColor: checkingViewModel
                                  .checkingModel.number3BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode3,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.numberFocusNode4,
                            ),
                            const SizedBox(width: 2),
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController4,
                              borderColor: checkingViewModel
                                  .checkingModel.number4BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode4,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.numberFocusNode5,
                            ),
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController5,
                              borderColor: checkingViewModel
                                  .checkingModel.number5BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode5,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.numberFocusNode6,
                            ),
                            const SizedBox(width: 2),
                            NumberInputField(
                              controller: checkingViewModel
                                  .checkingModel.numberController6,
                              borderColor: checkingViewModel
                                  .checkingModel.number6BorderColor.value,
                              focusNode: checkingViewModel
                                  .checkingModel.numberFocusNode6,
                              nextFocusNode: checkingViewModel
                                  .checkingModel.unusedFocusNode,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: checkingViewModel.drawController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Chọn số kỳ',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return checkingViewModel.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            checkingViewModel.onSuggestionSelected(suggestion);
                          },
                        ),

                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await checkingViewModel.checkingResults(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, // Màu nền trong suốt
                            onSurface:
                                Colors.white, // Màu chữ khi không được nhấn
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Text(
                              'Dò số',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
