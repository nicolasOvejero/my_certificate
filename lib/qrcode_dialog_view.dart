import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageDialog extends StatefulWidget {
  final String svg;

  ImageDialog(this.svg);

  @override
  ImageDialogState createState() => ImageDialogState();
}

class ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SvgPicture.string(widget.svg, width: 250, height: 250),
        )
      ),
    );
  }
}
