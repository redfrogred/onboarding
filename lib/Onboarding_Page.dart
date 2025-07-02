import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding_Page extends StatefulWidget {
  @override
  State<Onboarding_Page> createState() => _Onboarding_PageState();
}

class _Onboarding_PageState extends State<Onboarding_Page> {

  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage( { 
    required Color color, 
    required String url_image,
    required String title,
    required String subtitle
  }) => 
    Container (
      color: color,
      child: Center(
        child: Text( title, style: TextStyle( color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold ))
      )
    );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              index == 2 ? isLastPage = false : isLastPage = true;  
            });
          },
          children: [
            buildPage(
              color: Colors.pink,
              url_image: '',
              title: 'PAGE UNO',
              subtitle: 'This is a subtitle!'
            ),
            Container(
              color: Colors.green,
              child: const Center( child: Text('Page 2')),
            ),
            Container(
              color: Colors.yellow,
              child: const Center( child: Text('Page 3')),
            ),                    
          ],
        ),
      ),
      bottomSheet: isLastPage 
      ? 
        Container (
          color: Colors.black12, // match chrome
          height: 80,
          padding: const EdgeInsets.symmetric( horizontal: 20 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => controller.jumpToPage(3),
                child: Text('SKIP')
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.blue,
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration( milliseconds: 500), 
                    curve: Curves.easeIn,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child: Text('NEXT')
              ),            
            ],
          ),
        ) 
      : 
        
        Container (
          color: Colors.black12, // match chrome
          height: 80,
          child: Center(
            child: TextButton(
                onPressed: () {},
                child: Text('LET\'S GO!')
              ),     
            ),
        )  
    );
  }
}