import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/screens/home/hHeader.dart';
import 'package:todo/screens/home/hNote.dart';
import 'package:todo/screens/home/hSheet.dart';
import 'package:todo/screens/home/hTask.dart';
import 'package:todo/service/custom/style.dart';

class kHome extends StatefulWidget {
  @override
  State<kHome> createState() => _kHomeState();
}

class _kHomeState extends State<kHome> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    List<cPage> pages = [
      cPage(0, 'All', () {
        setState(() {
          page = 0;
        });
      }),
      cPage(1, 'Tasks', () {
        setState(() {
          page = 1;
        });
      }),
      cPage(2, 'Notes', () {
        setState(() {
          page = 2;
        });
      }),
    ];
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kPad(context) * 0.03, vertical: kPad(context) * 0.05),
        child: InkWell(
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
          child: SizedBox(
            height: kPad(context) * 0.25,
            width: kPad(context) * 0.25,
            child: LottieBuilder.network(
                'https://assets8.lottiefiles.com/packages/lf20_XyWejw.json'),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hHeader(),
            Padding(
              padding: EdgeInsets.only(left: kPad(context) * 0.05),
              child: Row(
                children: List.generate(
                    pages.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(right: kPad(context) * 0.05),
                          child: InkWell(
                            onTap: pages[index].press,
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == page ? Colors.white : null,
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: kPad(context) * 0.05,
                                  vertical: kPad(context) * 0.02),
                              child: Text(
                                pages[index].name,
                                style: style(context).copyWith(
                                    color: index == page ? dark : Colors.white),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: kPad(context) * 0.08,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: page == 1
                    ? Column(
                        children: [
                          hTask(),
                          SizedBox(
                            height: kPad(context) * 0.7,
                            width: kPad(context),
                            child: LottieBuilder.network(
                                'https://assets9.lottiefiles.com/packages/lf20_ilwhiuo7.json'),
                          )
                        ],
                      )
                    : page == 2
                        ? Column(
                            children: [
                              hNote(),
                              SizedBox(
                                height: kPad(context) * 0.7,
                                width: kPad(context),
                                child: LottieBuilder.network(
                                    'https://assets8.lottiefiles.com/packages/lf20_52uvnjhk.json'),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              hTask(),
                              SizedBox(
                                height: kPad(context) * 0.05,
                              ),
                              hNote(),
                              SizedBox(
                                height: kPad(context) * 0.1,
                              ),
                              SizedBox(
                                height: kPad(context) * 0.7,
                                width: kPad(context),
                                child: LottieBuilder.network(
                                    'https://assets5.lottiefiles.com/packages/lf20_wbwoxby3.json'),
                              ),
                              SizedBox(
                                height: kPad(context) * 0.3,
                              ),
                            ],
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cPage {
  final int no;
  final String name;
  final void Function() press;

  cPage(this.no, this.name, this.press);
}
