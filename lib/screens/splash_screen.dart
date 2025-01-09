import 'package:bingocaller/screens/main_layout_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(24, 152, 213, 1),
      // body: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Top Bingo",
      //         style: AppTheme.bingoStyle,
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_Screen_Image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
