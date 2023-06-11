import 'package:blug_club/auth.dart';
import 'package:blug_club/data.dart';
import 'package:blug_club/gen/assets.gen.dart';
import 'package:blug_club/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final items = AppDatabase.onBoardingItems;
  int _page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != _page) {
        setState(() {
          _page = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8),
              child: Assets.img.background.onboarding.image(),
            ),
          ),
          Container(
            height: 260,
            decoration: BoxDecoration(
                color: themeData.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20, color: Colors.black.withOpacity(0.1))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: items.length,
                      controller: _pageController,
                      itemBuilder: (contex, index) {
                        return Padding(
                          padding: const EdgeInsets.all(32),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].title,
                                  style: themeData.textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  items[index].description,
                                  style: themeData.textTheme.titleMedium!
                                      .apply(fontSizeFactor: 0.9),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                            controller: _pageController,
                            count: items.length,
                            effect: ExpandingDotsEffect(
                                dotWidth: 8,
                                dotHeight: 8,
                                activeDotColor: themeData.colorScheme.primary,
                                dotColor: themeData.colorScheme.primary
                                    .withOpacity(0.1))),
                        ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(84, 60)),
                                backgroundColor: MaterialStateProperty.all(
                                    themeData.colorScheme.primary),
                                foregroundColor: MaterialStateProperty.all(
                                    themeData.colorScheme.surface),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ))),
                            onPressed: () {
                              if (_page == items.length - 1) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthScreen()));
                              } else {
                                _pageController.animateToPage(_page + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              }
                            },
                            child: Icon(_page == items.length - 1
                                ? CupertinoIcons.check_mark
                                : CupertinoIcons.arrow_right))
                      ]),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
