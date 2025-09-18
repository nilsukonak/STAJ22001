import 'package:flutter/material.dart';
import 'package:todoapp/screens/newtasks.dart';
import 'package:todoapp/widgets/app_color.dart';

final containerrenk = const Color.fromARGB(253, 234, 232, 232);

// ignore: must_be_immutable
class Chipapp extends StatefulWidget {
  final TextEditingController prioritycont;
  List<String> chiplist;
  Chipapp({
    super.key,
    required this.prioritycont,
    required this.chiplist,
    required this.onchipselected,
    required bool showCheckmark,
  });
  final Function(String) onchipselected;
  @override
  State<Chipapp> createState() => _ChipappState();
}

class _ChipappState extends State<Chipapp> {
  int? selectedindex = 0;
  List<String> get chiplist => widget.chiplist;
  void initState() {
    super.initState();
    selectedindex = widget.chiplist.indexOf(widget.prioritycont.text);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MediaQuery.of(context).size.width * 0.04,
      children: List.generate(chiplist.length, (index) {
        return ChoiceChip(
          label: Text(
            chiplist[index],
            style: TextStyle(
              color: selectedindex == index ? Colors.white : Colors.black,
            ),
          ),

          selected: selectedindex == index,

          onSelected: (bool selected) {
            setState(() {
              selectedindex = selected ? index : null;
              prioritycont.text = chiplist[index];
            });
            if (selected) {
              widget.onchipselected(chiplist[index]);
            }
          },

          shape: StadiumBorder(),

          selectedColor: AppColors.buttonColor,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        );
      }),
    );
  }
}
