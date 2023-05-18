import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/service/model/tasks-model.dart';

import '../../service/custom/style.dart';
import '../../service/hive/add.dart';

class aTask extends StatefulWidget {
  @override
  State<aTask> createState() => _aTaskState();
}

class _aTaskState extends State<aTask> {
  DB db = DB();
  final box = Hive.box('app');

  Future<void> addT() async {
    await db.addTasks(DateTime.now(), cT.title, cT.task);
    await db.updateList();
    debugPrint('----------------- ${db.tasks.length} ------------------');
  }

  @override
  void initState() {
    super.initState();
    box.get('Tasks') == null ? db.createTasks() : db.loadList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (cT.task != [] && cT.title != '') {
          await addT();
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: kPad(context) * 0.05,
                    right: kPad(context) * 0.05,
                    top: kPad(context) * 0.13,
                    bottom: kPad(context) * 0.07),
                child: InkWell(
                  onTap: () async {
                    if (cT.task != [] && cT.title != '') {
                      await addT();
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                      height: kPad(context) * 0.13,
                      width: kPad(context) * 0.13,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle),
                      padding: EdgeInsets.all(kPad(context) * 0.04),
                      child: LottieBuilder.network(
                          'https://assets8.lottiefiles.com/private_files/lf30_gqgyoliq.json')),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPad(context) * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLines: null,
                        showCursor: false,
                        style: style(context).copyWith(
                            fontSize: kPad(context) * 0.1,
                            fontWeight: FontWeight.bold),
                        initialValue: cT.title,
                        onChanged: (v) {
                          setState(() {
                            cT.title = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Title',
                          hintStyle: style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: kPad(context) * 0.1,
                              color: Colors.white.withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cT.task.length + 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return index == cT.task.length
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.1)),
                                          value: false,
                                          onChanged: (v) {}),
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (v) {
                                            setState(() {
                                              cT.task.add(singleTask(v, false));
                                            });
                                            debugPrint(cT.toString());
                                          },
                                          maxLines: null,
                                          showCursor: false,
                                          style: style(context).copyWith(),
                                          decoration: InputDecoration(
                                            hintText: 'Enter new task',
                                            hintStyle: style(context).copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          side: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.1)),
                                          value: cT.task[index].isDone,
                                          onChanged: (v) {
                                            setState(() {
                                              cT.task[index].isDone =
                                                  !cT.task[index].isDone;
                                            });
                                          }),
                                      Expanded(
                                        child: TextFormField(
                                          maxLines: null,
                                          showCursor: false,
                                          style: style(context).copyWith(),
                                          initialValue: cT.task[index].name,
                                          onChanged: (v) {
                                            setState(() {
                                              cT.task[index].name = v;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Tasks cT = Tasks('', '', '', []);
}
