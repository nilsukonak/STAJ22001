import 'package:flutter/material.dart';
import 'package:todoapp/screens/newtasks.dart';

//TAKVİM KISMI
class Datesec extends StatefulWidget {
  const Datesec({super.key});

  @override
  State<Datesec> createState() => _DatesecState();
}

class _DatesecState extends State<Datesec> {
  DateTime? selecteddate;

  Future<void> selecteddte() async {
    final DateTime? pickeddate = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
    );

    setState(() {
      selecteddate = pickeddate;

      datecont.text =
          "${pickeddate?.day}/${pickeddate?.month}/${pickeddate?.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: datecont,
        decoration: InputDecoration(
          labelText: '  Date',
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 12),
        ),

        readOnly: true,
        onTap: () {
          selecteddte();
        },
      ),
    );
  }
}
