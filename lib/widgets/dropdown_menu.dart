import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todoapp/screens/newtasks.dart';

const List<String> categorylist = <String>['Work', 'School', 'Self'];

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    categorylist.map<MenuEntry>(
      (String name) => MenuEntry(value: name, label: name),
    ),
  );
  String? dropdownValue;
  void initState() {
    super.initState();
    dropdownValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12), // kenarlardan boşluk

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dropdownValue ??
                "Category", // başta 'Category', sonra seçilen değer
            //style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down), // Sadece ikon
            onSelected: (String value) {
              setState(() {
                dropdownValue = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return categorylist.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
