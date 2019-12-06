import 'package:flutter/material.dart';

class InforIconButton extends StatefulWidget {
  final Function updateInfor;
  final IconData selectedIcon;
  final IconData iconButton;

  InforIconButton({this.updateInfor, this.selectedIcon, this.iconButton});

  @override
  _InforIconButtonState createState() => _InforIconButtonState();
}

class _InforIconButtonState extends State<InforIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: widget.selectedIcon == widget.iconButton
                ? Colors.green
                : Colors.transparent,
            width: 25,
            height: 2,
          ),
          IconButton(
            icon: Icon(
              widget.iconButton,
              size: 25,
              color: widget.selectedIcon == widget.iconButton
                  ? Colors.green
                  : Colors.grey,
            ),
            onPressed: () {
              widget.updateInfor(widget.iconButton);
            },
          ),
        ],
      ),
    );
  }
}
