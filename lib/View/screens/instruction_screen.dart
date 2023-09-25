import 'package:do_so_655/ViewModel/instruction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  final InstructionViewModel instructionViewModel =
      Get.put(InstructionViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Hướng dẫn dùng app"),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
      ),
      body: Obx(
        () => SafeArea(
          child: Container(
            constraints: const BoxConstraints.expand(),
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
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            instructionViewModel.toggleLottoScreen();
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Màn hình Kết quả xổ số',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Đặt màu nền là trong suốt
                                    shadowColor: Colors
                                        .transparent, // Đặt màu bóng là trong suốt
                                  ),
                                  onPressed: () {
                                    instructionViewModel.toggleLottoScreen();
                                  },
                                  child: instructionViewModel.instructionModel
                                          .hidelottoScreen.value
                                      ? const Icon(Icons.zoom_out_map,
                                          color: Colors.white)
                                      : const Icon(Icons.minimize,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Visibility(
                        visible: instructionViewModel
                            .instructionModel.lottoScreen.value,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset(
                                    'assets/images/Lotto Screen.png'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Ở màn hình kết quả xổ số sẽ có đầy đủ các thông tin bao gồm Kỳ xổ số, ngày mở thưởng, 6 số thường, số đặc biệt, giá trị giải thưởng cũng như số người trúng thưởng.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'Về chức năng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút chọn kỳ xổ số: nằm phía trên màn hình, bạn có thể chọn kỳ từ trong danh sách hoặc nhập trực tiếp kỳ muốn hiển thị kết quả vào. Kỳ có màu vàng là kỳ có người trúng jackpot 1 hoặc jackpot2.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset('assets/images/period.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút chọn ngày xổ số: nằm ở phía dưới nút chọn kỳ, bạn có thể chọn ngày xổ từ trong danh sách hoặc nhập trực tiếp ngày muốn hiển thị kết quả vào dưới dạng dd/mm/yyyy. Ngày xổ có màu vàng là ngày có người trúng jackpot 1 hoặc jackpot 2.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Bên dưới kết quả 7 cặp số là phần giá trị giải thưởng, bạn có thể vuốt sang trái hoặc sang phải để chuyển sang kết quả kỳ kế tiếp. Khi có người trúng jackpot thì giải thưởng sẽ phát sáng tương ứng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            instructionViewModel.toggleCheckingScreen();
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Màn hình Dò số nhập',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Đặt màu nền là trong suốt
                                    shadowColor: Colors
                                        .transparent, // Đặt màu bóng là trong suốt
                                  ),
                                  onPressed: () {
                                    instructionViewModel.toggleCheckingScreen();
                                  },
                                  child: instructionViewModel.instructionModel
                                          .hidecheckingScreen.value
                                      ? const Icon(Icons.zoom_out_map,
                                          color: Colors.white)
                                      : const Icon(Icons.minimize,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Visibility(
                        visible: instructionViewModel
                            .instructionModel.checkingScreen.value,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child:
                                    Image.asset('assets/images/checking.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Ở màn hình dò số nhập sẽ có 6 ô số để nhập số muốn dò, nút chọn kỳ và nút dò số.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'Về chức năng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - 6 ô nhập số: Người dùng sẽ nhập 6 số tại đây để dò, sẽ có cảnh báo nếu nhập sai quy cách, ví dụ như nhập thiếu số, số ngoài khoảng từ 1 đến 55,...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút chọn kỳ: Khi bấm vào nó sẽ hiển thị tất cả các kỳ đang có trong cơ sở dữ liệu, chọn kỳ bạn muốn dò để hiển thị kết quả chính xác.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút dò số: Sau khi nhập đầy đủ các thông tin, nhấp vào nút Dò số để tiến hành dò số và nhận thông báo kết quả.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset(
                                    'assets/images/result_checking.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Sau khi nhấp vào nút dò số thì kết quả kỳ bạn muốn dò sẽ hiện lên, hiển thị thông báo bạn có trúng giải nào hay không, các số bạn nhập nếu trùng với kết quả sẽ có viền màu xanh lá cây. Bạn có thể nhấp vào nút Xóa hết số để xóa tất cả các số đã nhập trước đó.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            instructionViewModel.toggleChartScreen();
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Màn hình Thống kê/ biểu đồ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Đặt màu nền là trong suốt
                                    shadowColor: Colors
                                        .transparent, // Đặt màu bóng là trong suốt
                                  ),
                                  onPressed: () {
                                    instructionViewModel.toggleChartScreen();
                                  },
                                  child: instructionViewModel.instructionModel
                                          .hidechartScreen.value
                                      ? const Icon(Icons.zoom_out_map,
                                          color: Colors.white)
                                      : const Icon(Icons.minimize,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Visibility(
                        visible: instructionViewModel
                            .instructionModel.chartScreen.value,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset('assets/images/chart.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Ở màn hình Biểu đồ thống kê sẽ có ô nhập Kỳ bắt đầu và ô nhập kỳ kết thúc để chọn khoảng muốn thống kê, nút thống kê để tiến hành hiển thị thống kê, nút tùy chọn trên cùng với các tùy chọn ẩn hoặc hiện các dạng thống kê, biểu đồ cột, 2 nút sắp xếp biểu đồ cột, biểu đò đường, danh sách tần suất của các số trong kỳ được chọn để thống kê, 2 nút sắp xếp danh sách tần suất và thông tin trúng thưởng jackpot 1 và jackpot 2 ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'Về chức năng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - 2 ô Kỳ bắt đầu và Kỳ kết thúc: Người dùng sẽ nhập kỳ bắt đầu và kỳ kết thúc mà mình muốn để tiến hành thống kê , sẽ có cảnh báo tại ô nhập nếu nhập sai quy cách, ví dụ như nhập thiếu số, kỳ bắt đầu lớn hơn kỳ kết thúc,...Bạn có thể nhập 2 kỳ giống nhau để thống kê 1 kỳ duy nhất, nếu nhập kỳ kết thúc lớn hơn kỳ hiện có trong cơ sở dữ liệu sẽ trả về kết quả lớn nhất có trong cơ sở dữ liệu ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút thống kê: Khi bấm vào nó sẽ tiến hành thống kê và hiển thị ở phần biểu đồ cột, biểu đồ đường, danh sách tần suất các số, số tiền và số người trúng jackpot trong khoảng bạn chọn để thống kê.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Biểu đồ cột: Biểu đồ sẽ hiển thị tần suất của các số(số lần xuất hiện dựa trên tổng số kỳ) dưới dạng các cột, bên dưới biểu đồ là thứ tự các số từ 1 đến 55, cột ngoài cùng bên trái là tổng số lần xuất hiện của các số. Bạn có thể phóng to, thu nhỏ biểu đồ bằng thao tác thu phóng 2 ngón tay. Nhấp vào 1 cột sẽ hiển thị thông tin cột đó: cột đó của số nào. xuất hiện bao nhiêu lần. Bên phải biểu đồ là 2 biểu tượng sắp xếp biểu đồ theo thứ tự giảm dần và sắp xếp biểu đồ theo thứ tự từ 1 đến 55. Bên dưới là khoảng các kỳ mà bạn chọn để thống kê, trong trường hợp này bạn chọn kỳ kết thúc là 1000 nhưng trong cơ sở dữ liệu chỉ có 893 kỳ nên nó sẽ thống kê đến kỳ lớn nhất hiện có trong cơ sở dữ liệu ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Biểu đồ đường: Biểu đồ đường sẽ hiển thị tần suất các số dưới dạng đường. Bạn có thể thể phóng to, thu nhỏ trên biểu đồ này. Bấm vào điểm bất kỳ trên biểu đồ sẽ hiển thị thông báo về số nằm tại đó với tần suất tương ứng.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Danh sách tần suất của các số: Ở đây sẽ hiển thị danh sách các số từ 1 đến 55 cùng với tần suất xuất hiện của chúng dựa trên khoảng mà ta đã chọn. 2 biểu tượng bên phải danh sách là sắp xếp danh sách theo thứ tự tăng dần và sắp xếp danh sách theo thứ tự giảm dần.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Thông tin trúng thưởng: tại đây sẽ hiển thị thông tin tổng số người trúng thưởng các giải jackot 1 và jackot 2 cũng như tổng số tiền giải họ đã trúng .',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút tùy chọn: Nằm bên phải trên cùng màn hình, bạn có thể chọn ẩn hoặc hiện các dạng thống kê đang có bên dưới bên dưới.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            instructionViewModel.togglePredictionScreen();
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Màn hình Dự đoán/thống kê',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Đặt màu nền là trong suốt
                                    shadowColor: Colors
                                        .transparent, // Đặt màu bóng là trong suốt
                                  ),
                                  onPressed: () {
                                    instructionViewModel
                                        .togglePredictionScreen();
                                  },
                                  child: instructionViewModel.instructionModel
                                          .hidepredictionScreen.value
                                      ? const Icon(Icons.zoom_out_map,
                                          color: Colors.white)
                                      : const Icon(Icons.minimize,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Visibility(
                        visible: instructionViewModel
                            .instructionModel.predictionScreen.value,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child:
                                    Image.asset('assets/images/prediction.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Ở màn hình dự đoán và thống kê sẽ các chức năng như dự đoán hồi quy tuyến tính dự trên đầu vào là các số đã xổ trước đó, thống kê các số có tần suất xuất hiện nhiều nhất, thống kê các bộ 2, 3, 4, 5, 6 cặp số có tần suất xuất hiện cạo nhất,...và nút tùy chọn góc trên bên phải màn hình để ẩn hoặc hiện các chức năng hiện có trong màn hình ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'Về chức năng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút dự đoán và thống kê của tất cả các chức năng: Khi bấm vào sẽ thống kê và hiển thị các thông tin tương đương',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút tùy chọn: nằm phía trên bên phải màn hình, sẽ có các tùy chọn ẩn hoặc hiện các chức năng thống kê, dự đoán tương ứng.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            instructionViewModel.toggleCheckingAllScreen();
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Màn hình Dò tất cả các kỳ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .transparent, // Đặt màu nền là trong suốt
                                    shadowColor: Colors
                                        .transparent, // Đặt màu bóng là trong suốt
                                  ),
                                  onPressed: () {
                                    instructionViewModel
                                        .toggleCheckingAllScreen();
                                  },
                                  child: instructionViewModel.instructionModel
                                          .hidecheckingAllScreen.value
                                      ? const Icon(Icons.zoom_out_map,
                                          color: Colors.white)
                                      : const Icon(Icons.minimize,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Visibility(
                        visible: instructionViewModel
                            .instructionModel.checkingAllScreen.value,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset(
                                    'assets/images/checking_all.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Ở màn hình dò tất cả các kỳ sẽ có 6 ô để nhập số cần dò, nút dò số, nút xóa hết các số đã nhập và nút tùy chọn để lọc kết quả hiển thị. ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                'Về chức năng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - 6 ô nhập: Bạn sẽ nhập các số cần dò ở đây, sẽ có thông báo nếu nhập số sai quy cách.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút dò số: sau khi nhập đúng 6 số thì bấm dò số để tiến hành dò số.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: InteractiveViewer(
                                child: Image.asset(
                                    'assets/images/result_checking_all.jpg'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '(Bạn có thể phóng to, thu nhỏ ảnh này)',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Danh sách tất cả các số từ các kỳ xổ số: sau khi nhập đúng và bấm vào nút dò số thì bên dưới nút dò số sẽ hiển thị danh sách các số đã xổ ở tất cả các kỳ trước đó với kỳ và ngày xổ tương ứng. Các số trùng với số bạn nhập sẽ có viền tròn màu xanh lá cây. Nhấp vào các hàng số bất kỳ sẽ hiển thị thông tin tương ứng như: Kỳ, ngày xổ, giá trị jackpot1, giá trị jackpot 2, số người trúng jackpot 1, số người trúng jackpot2. Bạn cũng có thể lọc kết quả để hiển thị danh sách kết quả như ý muốn.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                ' - Nút tùy chọn: nằm ở phía trên bên phải màn hình. Nút có các chức năng như lọc các số trúng ít nhất 3, 4, 5, 6 số, khi chọn vào chức năng tương ứng danh sách kết quả sẽ chỉ hiển thị các kỳ có yêu cầu như trong tùy chọn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
