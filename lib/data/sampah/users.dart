class User {
  final String name;
  final String email;
  final String username;
  final String dob;
  final String age;
  final String location;
  final String occupation;
  final String about;
  final String gender;
  final String status;

  const User({
    required this.name,
    required this.email,
    required this.username,
    required this.dob,
    required this.age,
    required this.location,
    required this.occupation,
    required this.about,
    required this.gender,
    required this.status,
  });

  User copy({
    String? name,
    String? email,
    String? username,
    String? dob,
    String? age,
    String? location,
    String? occupation,
    String? about,
    String? gender,
    String? status,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        username: username ?? this.username,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        location: location ?? this.location,
        occupation: occupation ?? this.occupation,
        about: about ?? this.about,
        gender: gender ?? this.gender,
        status: status ?? this.status,
      );

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is User &&
  //         runtimeType == other.runtimeType &&
  //         firstName == other.firstName &&
  //         lastName == other.lastName &&
  //         age == other.age;

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      username.hashCode ^
      dob.hashCode ^
      age.hashCode ^
      age.hashCode ^
      location.hashCode ^
      occupation.hashCode ^
      about.hashCode ^
      gender.hashCode ^
      status.hashCode;
}
