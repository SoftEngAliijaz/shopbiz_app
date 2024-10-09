import 'package:flutter/material.dart';

class TipDiv extends StatefulWidget {
  final String title;
  final bool isTip;

  const TipDiv({
    super.key,
    required this.title,
    required this.isTip,
  });

  @override
  State<TipDiv> createState() => _TipDivState();
}

class _TipDivState extends State<TipDiv> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: size.height * 0.04,
        width: size.width * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Center(
          child: Text(widget.title),
        ),
      ),
    );
  }
}
