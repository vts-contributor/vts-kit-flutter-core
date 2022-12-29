import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatefulWidget {
  final String label;
  final List<T> data;
  final T? value;
  final void Function(T)? onSelected;

  const DropDownWidget(
      {Key? key,
      this.onSelected,
      required this.label,
      this.value,
      required this.data})
      : super(key: key);

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  final TextEditingController _controller = TextEditingController();
  late T selectedItem;

  @override
  void initState() {
    selectedItem = widget.value ?? widget.data.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        _showDropDownBottomSheet<T>(context, widget.data, selectedItem, (p0) {
          _controller.text = p0.toString();
          selectedItem = p0;
          widget.onSelected != null ? widget.onSelected!(p0) : null;
        }, widget.label);
      },
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
                    controller: _controller,
                    style: const TextStyle(color: Colors.black),
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
                  "assets/dropdown_icon.png",
                  width: 16,
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

void _showDropDownBottomSheet<T>(BuildContext context, List<T> data, T? value,
    void Function(T)? onSelected, String label) async {
  showModalBottomSheet<void>(
    context: context,
    barrierColor: Colors.black45,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _BodyWidget<T>(
        data: data,
        onSelected: onSelected,
        value: value,
        label: label,
      );
    },
  );
}

class _BodyWidget<T> extends StatefulWidget {
  final List<T> data;
  final T? value;
  final String label;
  final void Function(T)? onSelected;
  const _BodyWidget({
    Key? key,
    required this.label,
    required this.data,
    required this.onSelected,
    required this.value,
  }) : super(key: key);

  @override
  State<_BodyWidget> createState() => __BodyWidgetState<T>();
}

class __BodyWidgetState<T> extends State<_BodyWidget<T>> {
  late T selectedItem;

  Widget selectWidget(String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff192E35),
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  height: 24,
                  width: 24,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    border: Border.all(
                      color: selected ? Colors.red : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                AnimatedScale(
                  scale: selected ? 1 : 0,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  child: const CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedItem = widget.value ?? widget.data.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          for (var item in widget.data)
            selectWidget(item.toString(), item == selectedItem, () {
              setState(() {
                selectedItem = item;
              });
            }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),
                child: const Text(
                  'Đóng',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red,
                  ),
                ),
                child: const Text('Thêm mới'),
                onPressed: () {
                  widget.onSelected != null
                      ? widget.onSelected!(selectedItem)
                      : null;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
