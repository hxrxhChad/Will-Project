import 'package:hive/hive.dart';

class Data {
  List list = [];
  final myBox = Hive.box('myBox');
  void create() {
    list = [
      ['First Task', false],
      ['Second Task', false],
    ];
  }

  void loadData() {
    list = myBox.get('ToDoList');
  }

  void updateData() {
    myBox.put('ToDoList', list);
  }
}
