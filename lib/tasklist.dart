import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/widgets/app_color.dart';
import 'helpers/firestore_helper.dart';
import 'package:todoapp/screens/edittask.dart';
import 'package:todoapp/models/task_model.dart';

class Tasklist extends StatefulWidget {
  final String selectedFilter;
  const Tasklist({super.key, required this.selectedFilter});

  @override
  State<Tasklist> createState() => _TasklistState();
}

List<Taskmodel> tasklist = [];
List<Taskmodel> filteredTasks =
    []; //gorevleri gosteren ekranların filtrelenmesi içn

class _TasklistState extends State<Tasklist> {
  @override
  void initState() {
    super.initState();
    _loadtask();
  }

  @override
  void didUpdateWidget(covariant Tasklist oldWidget) {
    //bu did fluttern hazır fonksu,widget değiştiğind calısır YANİ ALL SECİNCE COMPLETED SECİNCE KENDİ KENDİNE TETİKLENİYO ZATEN sonra eegr eski filtreyle secilen aynı seğilde aplly ile filtreyi uyguladk
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedFilter != widget.selectedFilter) {
      // filtre değişmiş, filtreyi yeniden uygula

      _applyFilter();
    }
  }

  void _applyFilter() {
    setState(() {
      //burda filtreleme yapılabilir
      if (widget.selectedFilter == 'Active') {
        filteredTasks = tasklist.where((task) => task.isdone == false).toList();
      } else if (widget.selectedFilter == 'Completed') {
        filteredTasks = tasklist.where((task) => task.isdone == true).toList();
      } else {
        filteredTasks = List.from(tasklist);
        filteredTasks.sort((a, b) {
          //sıralama
          if (a.isdone == b.isdone) return 0; //aynıysa değişmez
          return a.isdone == false ? -1 : 1; //tekli değilse -1 yani uste
        });
      }
    });
  }

  Future<void> _loadtask() async {
    final loadedTask = await fetchTasksFromFirestore();
    if (!mounted) return;

    setState(() {
      tasklist = loadedTask;
    });
    _applyFilter(); //filtreyi uyguka
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = filteredTasks[index];
                //bu taskitems ddiğmz liste yukarda stful widget icinde tanımlandı o yuzden widgetten cagırıypruz listeyi
                //silme şeyi
                return Dismissible(
                  key: Key(task.id ?? index.toString()),
                  direction: DismissDirection.endToStart, // Sadece sağdan sola
                  onDismissed: (direction) async {
                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    if (uid != null && task.id != null) {
                      await dismisiblefunc(task); //???

                      setState(() {
                        tasklist.removeWhere((t) => t.id == task.id);
                        filteredTasks.removeWhere((t) => t.id == task.id);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task deleted')),
                      );
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: AppColors.buttonColor,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  child: Opacity(
                    opacity:
                        task.isdone ? 0.7 : 1.0, //tıklananın opaklıgı azalcak

                    child: Card(
                      //tıklanablr olck edt sayfası acılsn diye
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTask(taskmodel: task),
                            ),
                          ).then((value) {
                            //edit sayfasından dönünce listeyi tekrar yükle
                            _loadtask();
                          });
                        },
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isdone,
                            activeColor: Colors.black,
                            onChanged: (bool? value) async {
                              setState(() {
                                task.isdone =
                                    value ?? false; // Önce local güncelle
                              });
                              await updateisdone(task, value!);
                            },
                          ),

                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                  decoration:
                                      task.isdone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  // ignore: deprecated_member_use
                                  color:
                                      task.isdone
                                          // ignore: deprecated_member_use
                                          ? Colors.black.withOpacity(0.7)
                                          : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Row(
                                children: [
                                  Text(
                                    'Due: ${task.date} ,',
                                    style: TextStyle(
                                      color: const Color.fromARGB(147, 0, 0, 0),
                                    ),
                                  ),
                                  Text(
                                    ' Priority: ${task.priority}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(147, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
