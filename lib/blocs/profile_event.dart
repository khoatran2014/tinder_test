import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProfiles extends ProfileEvent {
  final SWIPETYPE swipeType;
  final Profile profile;

  FetchProfiles({@required this.swipeType,@required this.profile});
}
