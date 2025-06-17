import 'package:agbu/components/custon_button.dart';
import 'package:agbu/screens/welcome_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // مكتبة المؤشرات
import '../components/background_decoration.dart';
import '../constants.dart';

class FirstRunScreens extends StatefulWidget {
  const FirstRunScreens({super.key});

  @override
  State<FirstRunScreens> createState() => _FirstRunScreensState();
}

class _FirstRunScreensState extends State<FirstRunScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGroundDecoration(),
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    _buildPage(
                      text: 'Welcome to AGBU Chat App!',
                      buttonText: 'Next',
                      onPressed: () => _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceInOut,
                      ),
                    ),

                    _buildPage(
                      text:
                      'Enjoy connecting with your Hommies and stay updated!',
                      buttonText: 'Next',
                      onPressed: () => _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                    ),

                    _buildPage(
                      text:
                      'In this app, you can join and chat with the AGBU community!',
                      buttonText: 'Let’s Go!',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 12,
                    activeDotColor: kDarkBlue2,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String text,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          DefaultTextStyle(
            style: kMainTitleTextStyle.copyWith(
              fontSize: 24,
              fontFamily: 'times',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  text,
                  speed: const Duration(milliseconds: 80),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          const Spacer(),
          CustomButton(
            onPressed: onPressed,
            title: buttonText,
          ),
        ],
      ),
    );
  }
}
