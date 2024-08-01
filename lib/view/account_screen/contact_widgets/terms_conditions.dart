import 'package:flutter/material.dart';


class TermsAndConditions extends StatefulWidget {
  final String data;
  final String title;
  const TermsAndConditions({super.key, required this.data, required this.title});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text("${widget.data}"),
      ),
    );
  }
}
