// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../service/custom/style.dart';
import '../../service/hive/add.dart';

class ColorGenerator {
  static final List<Color> colorPalette = [
    const Color(0xff55efc4),
    const Color(0xff74b9ff),
    const Color(0xffffeaa7),
    const Color(0xfffab1a0),
    const Color(0xffff7675),
    const Color(0xfffd79a8),
  ];

  static Color getRandomColor() {
    return colorPalette[Random().nextInt(colorPalette.length)];
  }
}

class hNote extends StatefulWidget {
  @override
  State<hNote> createState() => _hNoteState();
}

class _hNoteState extends State<hNote> {
  DB db = DB();
  final box = Hive.box('app');

  @override
  void initState() {
    super.initState();
    box.get('Notes') == null ? db.createNotes() : db.loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(db.notes.length, (index) {
        int i = db.notes.length - index - 1;
        Color randomColor = ColorGenerator.getRandomColor();
        return Padding(
          padding: EdgeInsets.only(
              right: kPad(context) * 0.05,
              left: kPad(context) * 0.05,
              bottom: kPad(context) * 0.05),
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
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                        "Do you really want to delete this Notes File?",
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
                              db.notes.remove(db.notes[i]);
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
              width: kPad(context),
              decoration: BoxDecoration(
                  color: randomColor, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(kPad(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    db.notes[i].title,
                    style: style(context).copyWith(
                        color: dark2,
                        fontWeight: FontWeight.bold,
                        fontSize: kPad(context) * 0.1),
                  ),
                  SizedBox(
                    height: kPad(context) * 0.05,
                  ),
                  Text(
                    db.notes[i].description,
                    style: style(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: dark2.withOpacity(0.6),
                        fontSize: kPad(context) * 0.04),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
