import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/screens/tasks.dart' as widget;
import 'package:todoapp/tasklist.dart';

/// Firebase Task Fetch
/// Description:

Future<List<Taskmodel>> fetchTasksFromFirestore() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  final snapshot = await FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .collection('tasks')
      .get();

  final loadedTasks = snapshot.docs.map((doc) {
    final data = doc.data();
    return Taskmodel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: data['date'] ?? '',
      priority: data['priority'] ?? '',
      category: data['category'] ?? '',
      isdone: data['isdone'] ?? false,
    );
  }).toList();
  return loadedTasks;
}

//edittask sayfasında taskı guncelleyen helperfonks
Future<void> updatedTaskInFirestore(Taskmodel updatedTask) async {
  int index = tasklist.indexWhere((task) => task.id == updatedTask.id);
  if (index != -1) {
    tasklist[index] = updatedTask;
  }

  // Firestore güncelle
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    print('Güncellenecek ID: ${updatedTask.id}');

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('tasks')
        .doc(updatedTask.id) // Belgenin ID’si
        .update({
          'title': updatedTask.title,
          'description': updatedTask.description,
          'date': updatedTask.date,
          'priority': updatedTask.priority,
          'category': updatedTask.category,
        });
  }
}

//silmek

Future<void> dismisiblefunc(task) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null && task.id != null) {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('tasks')
        .doc(task.id)
        .delete();
  }
}

//isdoneyi guncelicek
Future<void> updateisdone(Taskmodel task, bool value) async {
  final indexInMainList = tasklist.indexWhere((t) => t.id == task.id);

  //filtered taskı guncelliyo secilene göre
  if (indexInMainList != -1) {
    tasklist[indexInMainList] = tasklist[indexInMainList].copyWith(
      isdone: value,
    );
  }
  // filteredTasks'ı yeniden filtrele
  if (widget.selectedFilter == 'Active') {
    filteredTasks = tasklist.where((t) => t.isdone == false).toList();
  } else if (widget.selectedFilter == 'Completed') {
    filteredTasks = tasklist.where((t) => t.isdone == true).toList();
  } else {
    filteredTasks = List.from(tasklist);
  }

  //veritabanını güncelle
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final taskId = task.id;
  if (uid != null && taskId != null) {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .update({'isdone': value});
  }
}
