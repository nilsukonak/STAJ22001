import 'package:flutter/material.dart';
import 'package:todoapp/helpers/firestore_helper.dart';
import 'package:todoapp/helpers/validation_helper.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/screens/newtasks.dart';
import 'package:todoapp/screens/tasks.dart';

import 'package:todoapp/widgets/app_color.dart';
import 'package:todoapp/widgets/chip_selector.dart';
import 'package:todoapp/widgets/date_picker.dart';
import 'package:todoapp/widgets/dropdown_menu.dart';

final _formKey =
    GlobalKey<FormState>(); //title için validate ile boş kontrolü yapacağız

class EditTask extends StatefulWidget {
  final Taskmodel taskmodel;
  const EditTask({super.key, required this.taskmodel});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  void initState() {
    super.initState();
    titlecont.text = widget.taskmodel.title;
    descriptioncont.text = widget.taskmodel.description;
    datecont.text = widget.taskmodel.date;
    prioritycont.text = widget.taskmodel.priority;
    categorycont.text = widget.taskmodel.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'Edit Task',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) => validateNotEmpty(value, 'Title'),
                      controller: titlecont,
                      decoration: InputDecoration(
                        labelText: '  Title',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: descriptioncont,
                  decoration: InputDecoration(
                    labelText: '  Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Datesec(),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),

                  Chipapp(
                    chiplist: ['Low', 'Medium', 'Heigh'],
                    prioritycont: prioritycont,
                    onchipselected: (String) {},
                    showCheckmark: true,
                  ),
                ],
              ),

              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownMenuExample(),
              ),

              SizedBox(height: 30),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final updatedTask = Taskmodel(
                        id: widget.taskmodel.id,
                        title: titlecont.text,
                        description: descriptioncont.text,
                        date: datecont.text,
                        priority: prioritycont.text,
                        category: categorycont.text,
                      );
                      await updatedTaskInFirestore(
                        //firestore_helper fonksiyonu
                        updatedTask,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Tasks()),
                      );
                    } else {
                      print('hata');
                    }
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
