import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundBotton extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  bool loading;

  RoundBotton(
      {super.key,
      required this.btnName,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(11)),
          child: Center(
              child: loading ? CircularProgressIndicator(strokeWidth:2,color: Colors.white,):Text(
            btnName,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
