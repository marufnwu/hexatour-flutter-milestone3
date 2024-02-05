import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Privacy Policy"),
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
