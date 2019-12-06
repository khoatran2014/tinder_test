import 'package:equatable/equatable.dart';

class Profiles {
  final List<Profile> profiles;

  Profiles({
    this.profiles,
  });

  factory Profiles.fromJson(List<dynamic> parsedJson) {
    List<Profile> profiles = new List<Profile>();
    profiles = parsedJson.map((i) => Profile.fromJson(i)).toList();
    return new Profiles(
      profiles: profiles,
    );
  }
}

class Profile {
  User user;
  String seed;
  String version;

  Profile({this.user, this.seed, this.version});

  Map<String, dynamic> toJson() => {
    "user": user,
    "seed": seed,
    "version": version
  };

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: User.fromJson(json['user']),
      seed: json['seed'],
      version: json['version'],
    );
  }
}

class User {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;
  final String registered;
  final String dob;
  final String phone;
  final String cell;
  final String SSN;
  final String picture;

  User({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
    this.registered,
    this.dob,
    this.phone,
    this.cell,
    this.SSN,
    this.picture,
  });

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "name": name,
        "location": location,
        "email": email,
        "username": username,
        "password": password,
        "salt": salt,
        "md5": md5,
        "sha1": sha1,
        "sha256": sha256,
        "registered": registered,
        "dob": dob,
        "phone": phone,
        "cell": cell,
        "SSN": SSN,
        "picture": picture
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      location: Location.fromJson(json['location']),
      email: json['email'],
      username: json['username'],
      password: json['password'],
      salt: json['salt'],
      md5: json['md5'],
      sha1: json['sha1'],
      sha256: json['sha256'],
      registered: json['registered'],
      dob: json['dob'],
      phone: json['phone'],
      cell: json['cell'],
      SSN: json['SSN'],
      picture: json['picture'],
    );
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({
    this.title,
    this.first,
    this.last,
  });

  Map<String, dynamic> toJson() =>
      {"title": title, "first": first, "last": last};

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Location {
  String street;
  String city;
  String state;
  String zip;

  Location({
    this.street,
    this.city,
    this.state,
    this.zip,
  });

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "zip": zip,
      };

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
    );
  }
}
