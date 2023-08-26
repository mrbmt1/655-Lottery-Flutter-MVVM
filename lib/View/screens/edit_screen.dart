import 'package:do_so_655/View/screens/import_screen.dart';
import 'package:do_so_655/ViewModel/edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class EditVietlott655Form extends StatefulWidget {
  @override
  _EditVietlott655FormState createState() => _EditVietlott655FormState();
}

class _EditVietlott655FormState extends State<EditVietlott655Form> {
  final EditViewModel editViewModel = Get.put(EditViewModel());

  @override
  void initState() {
    super.initState();
    editViewModel.getDrawPeriods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa thông tin kỳ xổ'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Vietlott655Form(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'add',
                child: Text('Thêm mới'),
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
            key: editViewModel.editModel.formKey,
            child: ListView(
              children: [
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller:
                        editViewModel.editModel.drawPeriodController.value,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Chọn kỳ cần sửa',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return editViewModel.editModel.drawPeriods.where((period) =>
                        period.toLowerCase().startsWith(pattern.toLowerCase()));
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    editViewModel.editModel.drawPeriodController.value.text =
                        suggestion;
                    editViewModel.loadDrawResult(suggestion);
                  },
                ),
                TextFormField(
                  controller: editViewModel.editModel.drawDateController.value,
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
                  onTap: () {
                    editViewModel.selectDate(context);
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
                        controller: editViewModel
                            .editModel.regularNumber1Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber1Controller.value),
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
                        controller: editViewModel
                            .editModel.regularNumber2Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber2Controller.value),
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
                        controller: editViewModel
                            .editModel.regularNumber3Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber3Controller.value),
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
                        controller: editViewModel
                            .editModel.regularNumber4Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber4Controller.value),
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
                        controller: editViewModel
                            .editModel.regularNumber5Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber5Controller.value),
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
                        controller: editViewModel
                            .editModel.regularNumber6Controller.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => editViewModel.validateNumber(
                            value,
                            editViewModel
                                .editModel.regularNumber6Controller.value),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller:
                      editViewModel.editModel.specialNumberController.value,
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
                  validator: (value) => editViewModel.validateNumber(value,
                      editViewModel.editModel.specialNumberController.value),
                ),
                TextFormField(
                  controller:
                      editViewModel.editModel.prize1ValueController.value,
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
                ),
                TextFormField(
                  controller:
                      editViewModel.editModel.prize2ValueController.value,
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
                ),
                TextFormField(
                  controller: editViewModel.editModel.jackpot1Controller.value,
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
                ),
                TextFormField(
                  controller:
                      editViewModel.editModel.jackpot1prizeController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText:
                        'Số tiền trúng(tự động chia dựa theo số người trúng)',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số tiền';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: editViewModel.editModel.jackpot2Controller.value,
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
                ),
                TextFormField(
                  controller:
                      editViewModel.editModel.jackpot2prizeController.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Số tiền trúng',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số tiền';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      editViewModel.updateForm(context);
                    },
                    child: const Text('Cập nhật'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
                    )),
                ElevatedButton(
                    onPressed: () {
                      editViewModel.deleteForm(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
                    child: const Text('Xóa')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
