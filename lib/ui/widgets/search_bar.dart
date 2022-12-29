import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController? controller;
  const SearchBar({Key? key, this.controller}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/search_icon.png",
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
                color: const Color(0xff8F9294),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: widget.controller,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 10)
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.controller?.clear();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/close_icon.png",
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown,
                color: const Color(0xff8F9294),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
