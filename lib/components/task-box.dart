// ignore_for_file: file_names
/*
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../common/style.dart';

class TaskBox extends StatelessWidget {
  final String name;
  final bool completed;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? delete;

  const TaskBox(
      {Key? key,
      required this.name,
      required this.completed,
      required this.onChanged,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: delete,
            icon: AntIcons.deleteFilled,
            backgroundColor: Colors.red.shade300,
          )
        ],
      ),
      child: Container(
        padding:
            const EdgeInsets.only(right: 30, top: 35, bottom: 35, left: 10),
        width: double.infinity,
        color: completed ? scaffoldColor(context) : blueC.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: completed,
              onChanged: onChanged,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                name,
                style: style(context).copyWith(
                    color:
                        shadowColor(context).withOpacity(completed ? 0.2 : 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*

RichText is a very useful widget in Flutter, which is used for displaying a paragraph of text on the UI with multiple styles. Inside the widget, we can have
 */
*/
