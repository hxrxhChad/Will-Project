import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/home/aCButton.dart';
import 'package:todo/screens/home/aField.dart';
import 'package:todo/screens/home/kHome.dart';
import 'package:todo/service/custom/navigator.dart';
import 'package:todo/service/custom/style.dart';

class eName extends StatefulWidget {
  @override
  State<eName> createState() => _eNameState();
}

class _eNameState extends State<eName> {
  String name = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kPad(context) * 0.2,
            ),
            SizedBox(
              height: kPad(context) * 0.7,
              width: kPad(context),
              child: LottieBuilder.network(
                  'https://assets3.lottiefiles.com/packages/lf20_fFlCuV.json'),
            ),
            SizedBox(
              height: kPad(context) * 0.02,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kPad(context) * 0.05,
                    vertical: kPad(context) * 0.04),
                child: Text(
                  'Enter your Name',
                  style: style(context).copyWith(
                      fontSize: kPad(context) * 0.1,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
              child: Text(
                'When a person leads a disciplined life, they set an easy path to success. They will develop an approach to happiness and a beautiful future ahead. ',
                style: style(context).copyWith(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: kPad(context) * 0.045),
              ),
            ),
            SizedBox(
              height: kPad(context) * 0.08,
            ),
            aField(
                label: 'Name',
                hintText: 'Enter a name',
                icon: CupertinoIcons.person,
                suffix: false,
                suffixIcon: AntIcons.checkOutlined,
                suffixFunction: () {},
                onChanged: (v) => setState(() => name = v),
                obscure: false),
            SizedBox(
              height: kPad(context) * 0.08,
            ),
            aCButton(
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref
                      .setString("name", name)
                      .whenComplete(() => replace(context, kHome()));
                },
                label: 'Continue')
          ],
        ),
      ),
    );
  }
}

// SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString("email", email);
