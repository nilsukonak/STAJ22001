import 'package:flutter/material.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/newtasks.dart';
import 'package:todoapp/tasklist.dart';
import 'package:todoapp/widgets/chip_selector.dart';
import 'package:todoapp/widgets/app_color.dart';

String selectedFilter = 'all';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use ?? sürümden dolayı willpopscope hata veriyor
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            'Task List ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Chipapp(
                    prioritycont: TextEditingController(),
                    chiplist: ['All', 'Completed', 'Active'],
                    onchipselected: (selected) {
                      setState(() {
                        selectedFilter = selected;
                      });
                    },
                    showCheckmark: true,
                  ),
                ],
              ),

              Tasklist(selectedFilter: selectedFilter),

              ///taskliste değişkeni gönderiyorum
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        MediaQuery.of(context).size.height * 0.18,
                        MediaQuery.of(context).size.width * 0.19,
                      ),
                      backgroundColor: AppColors.buttonColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Newtasks(),
                        ),
                      );
                    },

                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '+ ',
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Add Task',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
