import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final String title;
  final bool isShowBackButton;
  final Widget child;
  final Widget? actions;
  const LayoutWidget({
    Key? key,
    this.actions,
    required this.child,
    this.isShowBackButton = true,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/background_header.png",
              height: 90,
              width: width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: SafeArea(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 2,
                          bottom: 2,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Image.asset(
                                "assets/back_left_icon.png",
                                height: 40,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 2,
                          bottom: 2,
                          child: Center(
                            child: actions,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
