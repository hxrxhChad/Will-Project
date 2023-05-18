import 'package:flutter/material.dart';

import '../../service/custom/style.dart';

class aField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool suffix;
  final IconData suffixIcon;
  final void Function() suffixFunction;
  final Function(String) onChanged;
  final bool obscure;

  const aField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.icon,
      required this.suffix,
      required this.suffixIcon,
      required this.suffixFunction,
      required this.onChanged,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: style(context),
          ),
          SizedBox(
            height: kPad(context) * 0.05,
          ),
          Container(
            height: kPad(context) * 0.15,
            width: kPad(context),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextFormField(
                obscureText: obscure ? true : false,
                onChanged: onChanged,
                showCursor: false,
                style: style(context),
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: style(context)
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: SizedBox(
                    width: kPad(context) * 0.08,
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  suffixIcon: suffix
                      ? InkWell(
                          onTap: suffixFunction,
                          child: SizedBox(
                            width: kPad(context) * 0.08,
                            child: Center(
                              child: Icon(
                                suffixIcon,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
