import 'package:hive_flutter/hive_flutter.dart';

import '../model/notes-model.dart';
import '../model/tasks-model.dart';

class DB {
  List notes = [];
  List tasks = [];

  final box = Hive.box('app');

  addNotes(time, title, description) {
    notes
        .add(Notes(time.millisecondsSinceEpoch.toString(), title, description));
  }

  addTasks(time, title, task) {
    tasks.add(Tasks(time.millisecondsSinceEpoch.toString(), title,
        time.millisecondsSinceEpoch.toString(), task));
  }

  updateList() {
    box.put('Notes', notes);
    box.put('Tasks', tasks);
  }

  loadList() {
    notes = box.get('Notes');
    tasks = box.get('Tasks');
  }

  createNotes() {
    notes = [];
  }

  createTasks() {
    tasks = [];
  }
}
