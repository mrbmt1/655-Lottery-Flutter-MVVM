import 'package:do_so_655/Repository/vietlott_655_results_api/dio.dart';
import 'package:do_so_655/View/screens/edit_screen.dart';
import 'package:do_so_655/ViewModel/import_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Vietlott655Form extends StatefulWidget {
  const Vietlott655Form({super.key});

  @override
  _Vietlott655FormState createState() => _Vietlott655FormState();
}

class _Vietlott655FormState extends State<Vietlott655Form> {
  final ImportViewModel importViewModel = Get.put(ImportViewModel());

  @override
  void initState() {
    importViewModel.clearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập thông tin kỳ xổ'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditVietlott655Form(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Sửa thông tin kỳ'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => Container(
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
          child: Form(
            key: importViewModel.importModel.formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller:
                      importViewModel.importModel.drawPeriodController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kỳ xổ',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập kỳ xổ';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: importViewModel.importModel.drawPeriodFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.drawPeriodFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.drawDateFocusNode);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final intDrawPeriod = int.tryParse(newValue.text);
                      if (intDrawPeriod == null || intDrawPeriod < 0) {
                        return oldValue;
                      }
                      return newValue;
                    }),
                  ],
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.drawDateController.value,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Thời gian mở giải',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập thời gian mở giải';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: importViewModel.importModel.drawDateFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.drawDateFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.regularNumber1FocusNode);
                  },
                  onTap: () {
                    importViewModel.selectDate(context);
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 1',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber1Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber1Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber1FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber1FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.regularNumber2FocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 2',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber2Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber2Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber2FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber2FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.regularNumber3FocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 3',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber3Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber3Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber3FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber3FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.regularNumber4FocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 4',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber4Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber4Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber4FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber4FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.regularNumber5FocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 5',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber5Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber5Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber5FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber5FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.regularNumber6FocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'cặp 6',
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: importViewModel
                            .importModel.regularNumber6Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => importViewModel.validateNumber(
                            value,
                            importViewModel
                                .importModel.regularNumber6Controller.value),
                        textInputAction: TextInputAction.next,
                        focusNode:
                            importViewModel.importModel.regularNumber6FocusNode,
                        onEditingComplete: () {
                          importViewModel.importModel.regularNumber6FocusNode
                              .unfocus();
                          FocusScope.of(context).requestFocus(importViewModel
                              .importModel.specialNumberFocusNode);
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.specialNumberController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Cặp số đặc biệt',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => importViewModel.validateNumber(
                      value,
                      importViewModel
                          .importModel.specialNumberController.value),
                  textInputAction: TextInputAction.next,
                  focusNode: importViewModel.importModel.specialNumberFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.specialNumberFocusNode
                        .unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.jackpot1PrizeFocusNode);
                  },
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.prize1ValueController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Giá trị Jackpot 1',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập giá trị giải thưởng';
                    }
                    final prizeValue = int.tryParse(value);
                    if (prizeValue == null || prizeValue <= 30000000000) {
                      return 'Giá trị giải thưởng phải lớn hơn 30 tỷ';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: importViewModel.importModel.jackpot1PrizeFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.jackpot1PrizeFocusNode
                        .unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.jackpot2PrizeFocusNode);
                  },
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.prize2ValueController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Giá trị Jackpot 2',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập giá trị giải thưởng';
                    }
                    final prize2Value = int.tryParse(value);
                    if (prize2Value == null || prize2Value <= 120000000) {
                      return 'Giá trị giải thưởng phải lớn hơn 120 triệu';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: importViewModel.importModel.jackpot2PrizeFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.jackpot2PrizeFocusNode
                        .unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.jackpot1WinnerFocusNode);
                  },
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.jackpot1Controller.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Số người trúng Jackpot 1',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số người trúng Jackpot 1';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode:
                      importViewModel.importModel.jackpot1WinnerFocusNode,
                  onEditingComplete: () {
                    importViewModel.importModel.jackpot1WinnerFocusNode
                        .unfocus();
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.jackpot2WinnerFocusNode);
                  },
                ),
                TextFormField(
                  controller:
                      importViewModel.importModel.jackpot2Controller.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Số người trúng Jackpot 2',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số người trúng Jackpot 2';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode:
                      importViewModel.importModel.jackpot2WinnerFocusNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(
                        importViewModel.importModel.submitButtonFocusNode);
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => importViewModel.submitForm(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  focusNode: importViewModel.importModel.submitButtonFocusNode,
                  child: const Text('Lưu thông tin'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await getResultsFromAPItoFirebase(context);
                  },
                  child: const Text('Lấy dữ liệu từ API'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
