import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_app/Widgets/profileInfor.dart';
import 'package:tinder_app/blocs/bloc.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProfileSlide extends StatefulWidget {
  final List<Profile> profiles;
  final SWIPETYPE swipeType;

  ProfileSlide(this.profiles, this.swipeType);

  @override
  _ProfileSlideState createState() => _ProfileSlideState();
}

class _ProfileSlideState extends State<ProfileSlide> {
  final lightGrey = Color.fromRGBO(240, 240, 240, 1);
  PageController _pageController;

  ProfileBloc _profileBloc;

  void swipeLeft() {
    _profileBloc.add(FetchProfiles(swipeType: SWIPETYPE.SWIPE_LEFT));
  }

  void swipeRight(Profile profile) {
    _profileBloc
        .add(FetchProfiles(swipeType: SWIPETYPE.SWIPE_RIGHT, profile: profile));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemCount: widget.profiles.length,
        onPageChanged: (pageNumber) {
          if (pageNumber == widget.profiles.length - 1) {
            this.swipeRight(widget.profiles[pageNumber]);
          }
          if (pageNumber == 0) {
            this.swipeLeft();
          }
        },
        itemBuilder: (context, position) {
          return imageSlide(
              widget.profiles[position], position, widget.swipeType);
        });
  }

  imageSlide(Profile profile, int position, SWIPETYPE swipetype) {
    if (widget.swipeType == SWIPETYPE.SWIPE_LEFT && position <= 1) {
      _pageController.animateToPage(1,
          duration: Duration(microseconds: 1), curve: Curves.fastOutSlowIn);
    }
    return Opacity(
      opacity: 1,
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (context, widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - position;
            value = (1 - (value.abs() * 0.2.clamp(0.0, 1.0)));
          }
          return Center(
            child: Card(
              color: lightGrey,
              child: SizedBox(
                height: Curves.easeInOut.transform(value) * 400.0,
                width: Curves.easeInOut.transform(value) * 350.0,
                child: widget,
              ),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              ProfileInfor(
                user: profile.user,
              ),
              Container(
                alignment: Alignment.center,
                height: 190,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(profile.user.picture),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
