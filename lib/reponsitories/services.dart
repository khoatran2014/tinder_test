import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/utils/constants.dart';

class Services {
  Services._();

  static final Services profileServices = Services._();
  Client client = Client();
  Future<Profiles> getProfiles() async {
    final response = await client.get(AppData.baseUrl);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Profiles.fromJson(json.decode(response.body)["results"]);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load profiles');
    }
  }
}
