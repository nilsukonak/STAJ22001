import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/helpers/validation_helper.dart';
import 'package:todoapp/screens/tasks.dart';

import 'package:todoapp/tasklist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/widgets/app_color.dart';
import 'package:todoapp/widgets/date_picker.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/widgets/chip_selector.dart';
import 'package:todoapp/widgets/dropdown_menu.dart';
import 'package:todoapp/helpers/validation_helper.dart';

final _newformKey =
    GlobalKey<FormState>(); //title için validate ile boş kontrolü yapacağız

final TextEditingController titlecont = TextEditingController();
final TextEditingController descriptioncont = TextEditingController();

final TextEditingController datecont = TextEditingController();

final TextEditingController prioritycont = TextEditingController();

final TextEditingController categorycont = TextEditingController();

//firebaseden
final FirebaseAuth _auth = FirebaseAuth.instance;

String? get currentUserUid => _auth.currentUser?.uid;
//giriş yapms kullanıcıcnın uid degerini getter ile alıyoruz

class Newtasks extends StatefulWidget {
  const Newtasks({super.key});

  @override
  State<Newtasks> createState() => _NewtasksState();
}

class _NewtasksState extends State<Newtasks> {
  @override
  void initState() {
    //edittaskta duzenledgm son degerler new taskte de geliyodu bu yuzden temizledm
    super.initState();
    titlecont.clear();
    descriptioncont.clear();
    datecont.clear();
    prioritycont.clear();
    categorycont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          'New Task',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.06,

              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _newformKey,
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
            SizedBox(height: 15),

            Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.06,

              decoration: BoxDecoration(
                color: AppColors.lightGray, //email fln onun rengi ve etrafı
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

            Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.06,

              decoration: BoxDecoration(
                color: AppColors.lightGray, //email fln onun rengi ve etrafı
                borderRadius: BorderRadius.circular(15),
              ),

              child: DropdownMenuExample(),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Chipapp(
                  prioritycont: prioritycont,
                  chiplist: ['Low', 'Medium', 'Heigh'],
                  onchipselected: (String) {},
                  showCheckmark: true,
                ),
              ],
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
                  if (_newformKey.currentState!.validate()) {
                    //title kontrolu
                    final newTask = Taskmodel(
                      title: titlecont.text,
                      description: descriptioncont.text,
                      date: datecont.text,
                      priority: prioritycont.text,
                      category: categorycont.text,
                    );

                    //taskscollection sminde bir firestoreye referans olusturuyoz yani görevleri firestorede dogru yere kaydetmk icin kullanyoz
                    final tasksCollection = FirebaseFirestore.instance
                        .collection('user')
                        .doc(currentUserUid)
                        .collection('tasks');

                    //map seklinde manuel olrk koleksiyona yazıyoz
                    await tasksCollection.add({
                      'title': newTask.title,
                      'description': newTask.description,
                      'date': newTask.date,
                      'priority': newTask.priority,
                      'category': newTask.category,
                      'isdone': newTask.isdone,
                    });

                    tasklist.add(newTask); // listeye ekle

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Tasks()),
                    );
                  } else {
                    print('hata ');
                  }
                  titlecont.clear();
                  descriptioncont.clear();
                  datecont.clear();
                  prioritycont.clear();
                  categorycont.clear();
                },

                child: Text(
                  'Save Task',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
