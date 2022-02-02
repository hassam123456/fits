import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class splash extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(000000),
      body:  Center(
        child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_kzfpndct.json'),
      ),


    );
  }
}
