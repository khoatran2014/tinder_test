import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_app/models/profiles.dart';

class FavouriteList extends StatefulWidget {
  final List<Profile> profiles;

  FavouriteList(this.profiles);

  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return widget.profiles.length > 0
        ? ListView.builder(
            itemCount: widget.profiles.length,
            itemBuilder: (ctx, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.profiles[index].user.picture),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.profiles[index].user.name.last ?? "",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              widget.profiles[index].user.location.street ?? "",
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              widget.profiles[index].user.phone ?? "",
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : Container();
  }
}
