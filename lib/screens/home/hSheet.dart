import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/screens/home/aNote.dart';
import 'package:todo/screens/home/aTask.dart';
import 'package:todo/screens/home/eName.dart';
import 'package:todo/service/custom/navigator.dart';

import '../../service/custom/style.dart';

class hSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kPad(context) * 1,
      child: Column(
        children: [
          Container(
            height: kPad(context) * 0.25,
            width: kPad(context),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.1)))),
            padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
            child: Row(
              children: [
                SizedBox(
                  height: kPad(context) * 0.1,
                  width: kPad(context) * 0.1,
                  child: LottieBuilder.network(
                    'https://assets10.lottiefiles.com/packages/lf20_jxgqawba.json',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: kPad(context) * 0.05,
                ),
                Text(
                  'Add a new File',
                  style: style(context).copyWith(
                      fontSize: kPad(context) * 0.046,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => push(context, aNote()),
            child: Container(
              height: kPad(context) * 0.15,
              width: kPad(context),
              padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: kPad(context) * 0.1,
                    width: kPad(context) * 0.1,
                    child: Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    width: kPad(context) * 0.05,
                  ),
                  Text(
                    'Note',
                    style: style(context).copyWith(
                        fontSize: kPad(context) * 0.04,
                        color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => push(context, aTask()),
            child: Container(
              height: kPad(context) * 0.15,
              width: kPad(context),
              padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: kPad(context) * 0.1,
                    width: kPad(context) * 0.1,
                    child: Icon(
                      CupertinoIcons.checkmark,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    width: kPad(context) * 0.05,
                  ),
                  Text(
                    'Tasks',
                    style: style(context).copyWith(
                        fontSize: kPad(context) * 0.04,
                        color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => push(context, eName()),
            child: Container(
              height: kPad(context) * 0.15,
              width: kPad(context),
              padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: kPad(context) * 0.1,
                    width: kPad(context) * 0.1,
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    width: kPad(context) * 0.05,
                  ),
                  Text(
                    'Edit your Name',
                    style: style(context).copyWith(
                        fontSize: kPad(context) * 0.04,
                        color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
