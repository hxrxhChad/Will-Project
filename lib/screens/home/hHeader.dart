import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/home/hSheet.dart';

import '../../service/custom/style.dart';

class hHeader extends StatefulWidget {
  @override
  State<hHeader> createState() => _hHeaderState();
}

class _hHeaderState extends State<hHeader> {
  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sName = prefs.getString("name");
    sName != null
        ? setState(() {
            name = sName;
          })
        : null;
  }

  String name = 'You';

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: kPad(context) * 0.05,
          right: kPad(context) * 0.05,
          top: kPad(context) * 0.05,
          bottom: kPad(context) * 0.07),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: kPad(context) * 0.2,
                width: kPad(context) * 0.2,
                child: LottieBuilder.network(
                  DateTime.now().hour < 12 && DateTime.now().hour > 4
                      ? 'https://assets10.lottiefiles.com/packages/lf20_bknKi1.json'
                      : DateTime.now().hour > 12 && DateTime.now().hour < 21
                          ? 'https://assets10.lottiefiles.com/packages/lf20_Ps8Cmo.json'
                          : 'https://assets9.lottiefiles.com/packages/lf20_7ir2eqwg.json',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: kPad(context) * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTime.now().hour < 12 && DateTime.now().hour > 4
                        ? 'Good Morning'
                        : DateTime.now().hour > 12 && DateTime.now().hour < 21
                            ? 'Good Afternoon'
                            : 'Have a good Sleep',
                    style: style(context).copyWith(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: kPad(context) * 0.038),
                  ),
                  Text(
                    name,
                    style:
                        style(context).copyWith(fontSize: kPad(context) * 0.06),
                  ),
                ],
              )
            ],
          ),
          InkWell(
            onTap: () => showModalBottomSheet(
              backgroundColor: dark2,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              isScrollControlled: true,
              context: context,
              builder: (_) => hSheet(),
            ),
            child: Container(
                height: kPad(context) * 0.13,
                width: kPad(context) * 0.13,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle),
                padding: EdgeInsets.all(kPad(context) * 0.04),
                child: LottieBuilder.network(
                    'https://assets8.lottiefiles.com/private_files/lf30_cohh6wnz.json')),
          )
        ],
      ),
    );
  }
}
