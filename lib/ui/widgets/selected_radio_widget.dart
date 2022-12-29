import 'package:flutter/material.dart';

class SelectedRadioWidget<T> extends StatefulWidget {
  final bool enable;
  final List<T> values;
  final int? selectedIndex;
  final Function(T)? onChanged;
  const SelectedRadioWidget({
    Key? key,
    this.onChanged,
    required this.values,
    this.enable = true,
    this.selectedIndex,
  }) : super(key: key);

  @override
  State<SelectedRadioWidget<T>> createState() => _SelectedRadioWidgetState<T>();
}

class _SelectedRadioWidgetState<T> extends State<SelectedRadioWidget<T>> {
  Widget typeSelectWidget(String label, bool selected, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Row(
        children: [
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
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff192E35),
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  void onChanged(int i) {
    if (!widget.enable) return;
    setState(() {
      selectedIndex = i;
    });
    widget.onChanged != null ? widget.onChanged!(widget.values[i]) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enable ? 1 : 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < widget.values.length; i++)
            typeSelectWidget(widget.values[i].toString(), selectedIndex == i, () {
              onChanged(i);
            }),
        ],
      ),
    );
  }
}
