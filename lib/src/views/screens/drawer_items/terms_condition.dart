import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Terms & Condition"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorConst.kGreenColor,
              image: DecorationImage(
                image: AssetImage("assets/images/appbar.png"),
              ),
            ),
          ),
        ),
      body: Container(
        child: Text('lorem ipsummmmmmmmmmmmmmmmmmmmmmmmmmmm'),
      ),
    );
  }
}
