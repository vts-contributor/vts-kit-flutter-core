import 'package:flutter/material.dart';

class TextInputButtonWidget extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final TextEditingController controller;
  const TextInputButtonWidget({Key? key, required this.controller, required this.label, this.onTap})
      : super(key: key);

  @override
  State<TextInputButtonWidget> createState() => _TextInputButtonWidgetState();
}

class _TextInputButtonWidgetState extends State<TextInputButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xffC4C4C4),
                width: 0.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: widget.label,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/right_arrow_icon.png",
                  width: 18,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
