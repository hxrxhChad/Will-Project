// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo/common/style.dart';

class AddTask extends StatelessWidget {
  final controller;
  final VoidCallback onTap;
  const AddTask({Key? key, required this.controller, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: darkC,
      backgroundColor: primaryColor(context),
      content: Container(
        height: 170,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                cursorColor: Colors.white,
                style: style(context),
                controller: controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'Add',
                      style: style(context).copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
