import 'package:flutter/material.dart';
import 'package:tinder_app/Widgets/infoIconButton.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';

class ProfileInfor extends StatefulWidget {
  final User user;

  ProfileInfor({this.user});

  @override
  _ProfileInforState createState() => _ProfileInforState();
}

class _ProfileInforState extends State<ProfileInfor> {
  final lightGrey = Color.fromRGBO(240, 240, 240, 1);
  String title = "";
  String description = "";
  IconData selectedIcon = null;

  void updateInfor(IconData iconData) {
    if (iconData == Icons.person) {
      setState(() {
        title = ProfileTitle.myName;
        description = widget.user.name.last;
        selectedIcon = iconData;
      });
    }
    if (iconData == Icons.calendar_today) {
      setState(() {
        title = ProfileTitle.myDoB;
        description = widget.user.dob;
        selectedIcon = iconData;
      });
    }
    if (iconData == Icons.location_on) {
      setState(() {
        title = ProfileTitle.myAddress;
        description = widget.user.location.street;
        selectedIcon = iconData;
      });
    }
    if (iconData == Icons.phone) {
      setState(() {
        title = ProfileTitle.myName;
        description = widget.user.phone;
        selectedIcon = iconData;
      });
    }
    if (iconData == Icons.lock_outline) {
      setState(() {
        title = ProfileTitle.myName;
        description = widget.user.email;
        selectedIcon = iconData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = "My address is";
    description = widget.user.location.street;
    selectedIcon = Icons.location_on;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ))),
      margin: EdgeInsets.only(
        top: 130,
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 60,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InforIconButton(
                    updateInfor: this.updateInfor,
                    selectedIcon: selectedIcon,
                    iconButton: Icons.person),
                InforIconButton(
                    updateInfor: this.updateInfor,
                    selectedIcon: selectedIcon,
                    iconButton: Icons.calendar_today),
                InforIconButton(
                    updateInfor: this.updateInfor,
                    selectedIcon: selectedIcon,
                    iconButton: Icons.location_on),
                InforIconButton(
                    updateInfor: this.updateInfor,
                    selectedIcon: selectedIcon,
                    iconButton: Icons.phone),
                InforIconButton(
                    updateInfor: this.updateInfor,
                    selectedIcon: selectedIcon,
                    iconButton: Icons.lock_outline),
              ],
            ),
          )
        ],
      ),
    );
  }
}
