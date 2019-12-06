import 'package:equatable/equatable.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileUninitialized extends ProfileState {}

class ProfileError extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<Profile> profiles;
  final SWIPETYPE swipetype;
  final List<Profile> favouriteProfiles;

  const ProfileLoaded({
    this.profiles,
    this.swipetype,
    this.favouriteProfiles
  });

  @override
  List<Object> get props => [profiles, swipetype, favouriteProfiles];

  @override
  String toString() => 'ProfilesLoaded { profiles: ${profiles.length}}';
}
