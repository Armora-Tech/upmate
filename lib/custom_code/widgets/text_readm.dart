// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:readmore/readmore.dart';

class TextReadm extends StatefulWidget {
  const TextReadm({
    Key? key,
    this.width,
    this.height,
    required this.text,
    required this.colorb,
    required this.trimline,
    required this.collapmsg,
    required this.readmorecolor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String text;
  final Color colorb;
  final int trimline;
  final String collapmsg;
  final Color readmorecolor;

  @override
  _TextReadmState createState() => _TextReadmState();
}

class _TextReadmState extends State<TextReadm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height:DeviceSize.height(context),
      child: ReadMoreText(
        widget.text,
        trimLines: widget.trimline,
        trimMode: TrimMode.Line,
        style: TextStyle(color: widget.colorb),
        colorClickableText: widget.readmorecolor,
        trimCollapsedText: widget.collapmsg,
        trimExpandedText: ' Less',
      ),
    );
  }
}
