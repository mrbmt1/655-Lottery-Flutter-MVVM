import 'package:do_so_655/View/screens/chart_screen.dart';
import 'package:do_so_655/View/screens/checking_screen.dart';
import 'package:do_so_655/View/screens/checking_all_screen.dart';
import 'package:do_so_655/View/screens/import_screen.dart';
import 'package:do_so_655/View/screens/instruction_screen.dart';
import 'package:do_so_655/View/screens/prediction_screen.dart';
import 'package:do_so_655/View/screens/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text('Menu',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            // ListTile(
            //   leading: Icon(Icons.camera_outlined, color: Colors.white),
            //   title: Stack(
            //     children: [
            //       Text(
            //         'Dò số bằng camera',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           shadows: [
            //             Shadow(
            //               blurRadius: 2,
            //               color: Colors.black.withOpacity(0.4),
            //               offset: Offset(2, 2),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Positioned(
            //         top: 0,
            //         right: 0,
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            //           decoration: BoxDecoration(
            //             color: Colors.yellow,
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Text(
            //             'Premium',
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 10,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: Text(
            //               'Tính năng sẽ được ra mắt ở phiên bản chính thức'),
            //           actions: [
            //             TextButton(
            //               child: Text('OK'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   },
            // ),
            ListTile(
              leading:
                  const Icon(Icons.find_in_page_rounded, color: Colors.white),
              title: Text(
                'Nhập dữ liệu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Vietlott655Form()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.find_in_page_rounded, color: Colors.white),
              title: Text(
                'Dò số nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart, color: Colors.white),
              title: Text(
                'Thống kê',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChartScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.stars_outlined, color: Colors.white),
              title: Text(
                'Dự đoán',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PredictionScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.find_replace, color: Colors.white),
              title: Text(
                'Dò tất cả các kỳ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CheckingAllScreen()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.support_agent_rounded, color: Colors.white),
              title: Text(
                'Liên hệ và hỗ trợ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SupportScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_rounded, color: Colors.white),
              title: Text(
                'Hướng dẫn dùng app',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InstructionScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Thoát',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2.5, 2.5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thoát'),
                      content:
                          const Text('Bạn muốn thoát khỏi ứng dụng không?'),
                      actions: [
                        TextButton(
                          child: const Text('Không'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Có'),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
