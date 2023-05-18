import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/service/hive/add.dart';
import 'package:todo/service/model/notes-model.dart';

import '../../service/custom/style.dart';

class aNote extends StatefulWidget {
  @override
  State<aNote> createState() => _aNoteState();
}

class _aNoteState extends State<aNote> {
  DB db = DB();
  final box = Hive.box('app');

  Future<void> addN() async {
    await db.addNotes(DateTime.now(), cN.title, cN.description);
    await db.updateList();
    debugPrint('----------------- ${db.notes.length} ------------------');
  }

  @override
  void initState() {
    super.initState();
    box.get('Notes') == null ? db.createNotes() : db.loadList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (cN.description != '' && cN.title != '') {
          await addN();
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                    if (cN.description != '' && cN.title != '') {
                      await addN();
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
                        initialValue: cN.title,
                        onChanged: (v) {
                          setState(() {
                            cN.title = v;
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
                      TextFormField(
                        maxLines: null,
                        showCursor: false,
                        style: style(context).copyWith(),
                        initialValue: cN.description,
                        onChanged: (v) {
                          setState(() {
                            cN.description = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Text',
                          hintStyle: style(context)
                              .copyWith(color: Colors.white.withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Notes cN = Notes('', '', '');
}
