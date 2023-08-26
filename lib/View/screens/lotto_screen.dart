import 'package:do_so_655/View/widgets/lottery_widget/app_drawer_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/draw_code_button_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/draw_date_button_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/jackpot1_number_winner_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/jackpot1_prize_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/jackpot2_number_winner_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/jackpot2_prize_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/result_text_widget.dart';
import 'package:do_so_655/View/widgets/lottery_widget/row_seven_numbers_result_widget.dart';
import 'package:do_so_655/ViewModel/lotto_view_model.dart';
import 'package:do_so_655/utils/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({super.key});

  @override
  _LotteryScreenState createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  final LotteryViewModel lotteryViewModel = Get.put(LotteryViewModel());

  @override
  void initState() {
    super.initState();
    internetChecking(context);
    lotteryViewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Kết quả Vietlott 6/55"),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 22, 25, 179),
      ),
      drawer: const AppDrawer(),
      body: Obx(
        () => SafeArea(
          child: Center(
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
                child: Stack(children: [
                  if (lotteryViewModel.lotteryModel.jackpot1Winner > 0 ||
                      lotteryViewModel.lotteryModel.jackpot2Winner > 0)
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/jackpotwin.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        //draw Code Button
                        drawCodeWidget(context),
                        //draw Date Button
                        drawDateWidget(context),
                        const SizedBox(height: 30),
                        //"Kết quả xổ số" text
                        resultText(),
                        const SizedBox(height: 10),
                        //7 numbers result
                        rowSevenNumberResult(),
                        const SizedBox(height: 30),
                        //Jackpot1 prize
                        jackpot1PrizeWidget(context),
                        const SizedBox(height: 12),
                        //Jackpot2 prize
                        jackpot2PrizeWidget(context),
                        const SizedBox(height: 10),
                        //number winner jackpot 1
                        numberWinnerJackpot1(),
                        const SizedBox(height: 10),
                        //number winner jackpot 2
                        numberWinnerJackpot2(),
                        // SizedBox(height: 80),
                      ],
                    ),
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}
