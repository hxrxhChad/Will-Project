import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/service/custom/style.dart';

import '../../service/hive/add.dart';

class ColorGenerator {
  static final List<Color> colorPalette = [
    const Color(0xff55efc4),
    const Color(0xff74b9ff),
    const Color(0xffffeaa7),
    const Color(0xfffab1a0),
    const Color(0xfffd79a8),
  ];

  static Color getRandomColor() {
    return colorPalette[Random().nextInt(colorPalette.length)];
  }
}

class hTask extends StatefulWidget {
  @override
  State<hTask> createState() => _hTaskState();
}

class _hTaskState extends State<hTask> {
  DB db = DB();
  final box = Hive.box('app');
  @override
  void initState() {
    super.initState();
    box.get('Tasks') == null ? db.createTasks() : db.loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kPad(context) * 0.05),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(db.tasks.length, (j) {
            int index = db.tasks.length - j - 1;
            Color randomColor = ColorGenerator.getRandomColor();
            return Padding(
              padding: EdgeInsets.only(right: kPad(context) * 0.05),
              child: InkWell(
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: dark2,
                    shadowColor: dark2.withOpacity(0.1),
                    contentPadding: const EdgeInsets.all(0),
                    content: Container(
                      height: kPad(context) * 1.1,
                      width: kPad(context) * 0.8,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(kPad(context) * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: kPad(context) * 0.5,
                            width: kPad(context) * 0.8,
                            child: LottieBuilder.network(
                                'https://assets9.lottiefiles.com/packages/lf20_az0MhjvO6G.json'),
                          ),
                          Text(
                            "Do you really want to delete this task File?",
                            textAlign: TextAlign.center,
                            style: style(context),
                          ),
                          SizedBox(
                            height: kPad(context) * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPad(context) * 0.05,
                                      vertical: kPad(context) * 0.03),
                                  child: Text(
                                    'Cancel',
                                    style: style(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: kPad(context) * 0.05,
                              ),
                              InkWell(
                                onTap: () => setState(() {
                                  db.tasks.remove(db.tasks[index]);
                                  db.updateList();
                                  Navigator.pop(context);
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: dark,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kPad(context) * 0.05,
                                      vertical: kPad(context) * 0.03),
                                  child: Text(
                                    'OK',
                                    style: style(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                child: Container(
                  width: kPad(context) * 0.7,
                  decoration: BoxDecoration(
                      color: randomColor,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(kPad(context) * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              db.tasks[index].title,
                              style: style(context).copyWith(
                                  fontSize: kPad(context) * 0.06,
                                  color: dark2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: dark2, shape: BoxShape.circle),
                                padding: EdgeInsets.all(kPad(context) * 0.02),
                                child: Text(
                                  DateFormat('dd').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(db.tasks[index].time)),
                                  ),
                                  style: style(context).copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: kPad(context) * 0.037),
                                ),
                              ),
                              Text(
                                DateFormat('MMMM').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(db.tasks[index].time)),
                                ),
                                style: style(context).copyWith(
                                    color: dark2.withOpacity(0.6),
                                    fontSize: kPad(context) * 0.037),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: kPad(context) * 0.02,
                      ),
                      Column(
                        children:
                            List.generate(db.tasks[index].task.length, (i) {
                          int newI = db.tasks[index].task.length - i - 1;
                          return CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              db.tasks[index].task[newI].name,
                              style: style(context).copyWith(
                                  color: dark2.withOpacity(0.6),
                                  fontSize: kPad(context) * 0.037,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: db.tasks[index].task[newI].isDone,
                            onChanged: (bool? value) {
                              setState(() {
                                db.tasks[index].task[newI].isDone =
                                    !db.tasks[index].task[newI].isDone;
                              });
                              db.updateList();
                            },
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
