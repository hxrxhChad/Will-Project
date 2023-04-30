// ignore_for_file: file_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:todo/components/add-task.dart';
import 'package:todo/components/task-box.dart';
import 'package:todo/service/database.dart';

import '../common/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('myBox');
  Data db = Data();
  final TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (myBox.get('ToDoList') == null) {
      db.create();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: primaryColor(context), // transparent status bar
          systemNavigationBarColor:
              scaffoldColor(context), // navigation bar color
          statusBarIconBrightness: Brightness.light, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
            key: key,
            drawerEdgeDragWidth: 300,
            drawer: SafeArea(
              child: Container(
                height: double.infinity,
                width: 300,
                color: primaryColor(context).withOpacity(1),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Text(
                          'To Do',
                          style: style(context)
                              .copyWith(color: Colors.white, fontSize: 30),
                        )),
                    SizedBox(
                      width: 200,
                      child: Divider(
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                        splashColor: Colors.white,
                        onTap: () =>
                            AdaptiveTheme.of(context).toggleThemeMode(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.brightness_solid,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Change Theme',
                                style: style(context)
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: InkWell(
                onTap: () => addTask(),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: primaryColor(context),
                      borderRadius: BorderRadius.circular(7)),
                  child: Icon(
                    CupertinoIcons.add,
                    color: scaffoldColor(context),
                  ),
                ),
              ),
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar.large(
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: primaryColor(context),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      key.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      CupertinoIcons.ellipsis_vertical,
                      color: Colors.white,
                    ),
                  ),
                  expandedHeight: 160,
                  elevation: 0,
                  backgroundColor: primaryColor(context),
                  toolbarHeight: 80,
                  collapsedHeight: 80,
                  titleTextStyle: style(context).copyWith(color: Colors.white),
                  title: const Text(
                    'To Do',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SliverList.builder(
                    itemCount: db.list.length,
                    itemBuilder: (context, index) {
                      return TaskBox(
                        name: db.list[index][0],
                        completed: db.list[index][1],
                        onChanged: (v) => changed(v, index),
                        delete: (context) => deleteFn(index),
                      );
                    })
              ],
            )));
  }

  //
  changed(bool? value, int index) {
    setState(() {
      db.list[index][1] = !db.list[index][1];
    });
    db.updateData();
  }

  addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AddTask(
            controller: controller,
            onTap: newTask,
          );
        });
  }

  newTask() {
    setState(() {
      db.list.add([controller.text, false]);
      controller.clear();
    });
    Navigator.pop(context);
    db.updateData();
  }

  deleteFn(int index) {
    setState(() {
      db.list.removeAt(index);
    });
    db.updateData();
  }
}
