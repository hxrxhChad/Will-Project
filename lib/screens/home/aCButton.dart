import 'package:flutter/material.dart';

import '../../service/custom/style.dart';

class aCButton extends StatelessWidget {
  final bool loading;
  final String label;

  final void Function() onTap;

  const aCButton({
    super.key,
    required this.loading,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: dark2,
          borderRadius: BorderRadius.circular(5),
          elevation: 20,
          shadowColor: dark2.withOpacity(0.7),
          child: Container(
            height: kPad(context) * 0.15,
            width: kPad(context),
            decoration: BoxDecoration(
                color: dark2, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: loading
                  ? SizedBox(
                      height: kPad(context) * 0.05,
                      width: kPad(context) * 0.05,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Text(
                      label,
                      style:
                          style(context).copyWith(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
