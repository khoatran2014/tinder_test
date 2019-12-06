import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tinder_app/blocs/bloc.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/reponsitories/dataHelper.dart';
import 'package:tinder_app/reponsitories/services.dart';
import 'package:tinder_app/utils/constants.dart';
import 'dart:convert';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final http.Client httpClient;

  ProfileBloc({@required this.httpClient});

  @override
  Stream<ProfileState> transformEvents(
    Stream<ProfileEvent> events,
    Stream<ProfileState> Function(ProfileEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<ProfileEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  // TODO: implement initialState
  ProfileState get initialState => ProfileUninitialized();

  Future<List<Profile>> getFavouriteList({Profile newProfile = null}) async {
    List<Profile> profiles = List<Profile>();
    String profilesData = await DataHelper.profile.getProfiles();
    if (profilesData.length > 0) {
      profiles = Profiles.fromJson(json.decode(profilesData)).profiles;
    }
    if (newProfile != null) {
      profiles.add(newProfile);
    }
    return profiles;
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    final currentState = state;
    if (event is FetchProfiles) {
      try {
        if (currentState is ProfileUninitialized) {
          List<Profile> profiles = List<Profile>();
          //Init 3 items
          for (int i = 0; i < 3; i++) {
            final result = await Services.profileServices.getProfiles();
            profiles.addAll(result.profiles);
          }

          List<Profile> favouriteProfiles = await getFavouriteList();

          yield ProfileLoaded(profiles: profiles, favouriteProfiles: favouriteProfiles);
          return;
        }
        if (currentState is ProfileLoaded) {
          final result = await Services.profileServices.getProfiles();
          if (result.profiles.isNotEmpty) {
            if (event.swipeType == SWIPETYPE.SWIPE_RIGHT) {

              //Add favourite profile
              List<Profile> favouriteProfiles = await getFavouriteList(newProfile: event.profile);
              var json = jsonEncode(favouriteProfiles.map((e) => e.toJson()).toList());
              DataHelper.profile.saveProfile(json);

              //Refresh State
              yield ProfileLoaded(
                  profiles: currentState.profiles + result.profiles,
                  swipetype: event.swipeType,
                  favouriteProfiles: favouriteProfiles);
            } else {
              List<Profile> favouriteProfiles = await getFavouriteList();
              yield ProfileLoaded(
                  profiles: result.profiles + currentState.profiles,
                  swipetype: event.swipeType,
                  favouriteProfiles: favouriteProfiles);
            }
          }
        }
      } catch (_) {
        yield ProfileError();
      }
    }
  }
}
