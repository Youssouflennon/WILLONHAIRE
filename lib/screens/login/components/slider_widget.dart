import 'dart:async';

import 'package:admin/color_constants.dart';
import 'package:admin/screens/login/components/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double? screenWidth;
  Timer? timer;
  int currentIndex = 0;
  int? totalIndex;
  final controller = PageController();
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(Duration(seconds: 5), (time) {
        if (currentIndex < totalIndex!) {
          controller.animateTo(currentIndex * (screenWidth!),
              duration: Duration(milliseconds: 1000), curve: Curves.ease);
          currentIndex++;
        } else {
          currentIndex = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 2;
    totalIndex = slides.length;
    return Container(
      child: PageView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        //controller: _pageController,
        controller: controller,
        children: List.generate(
          slides.length,
              (int index) => GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(left: 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: [], color: Color(slides[index].kBackgroundColor!)),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2 - 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(slides[index].image!),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: [],
                            color: Color(0xFFAC0B4C)),
                      ),
                    ],
                  ),
                  Positioned(
                    //top: MediaQuery.of(context).size.height / 1.4,

                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(slides[index].productImage!),
                              ),
                              boxShadow: [],
                              color: Color(0xFF00B4FF)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: slides[index].text!,
                                    style: TextStyle(color: Palette.Text, fontSize: 30, letterSpacing: 2)),

                              ]
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: slides.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: Colors.white,
                                dotColor: Colors.white.withOpacity(0.2),
                                dotHeight: 4.8,
                                dotWidth: 6,
                                spacing: 4.8),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
