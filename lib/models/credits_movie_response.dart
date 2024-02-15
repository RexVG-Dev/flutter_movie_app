import 'dart:convert';

class CreditsMovieReponse {
  int id;
  List<Cast> cast;
  List<Cast> crew;

  CreditsMovieReponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  // it's important to se the instance "fromJson" instead of "fromRawJson"   and "fromMap" instead of "fromJson"
  factory CreditsMovieReponse.fromJson(String str) => CreditsMovieReponse.fromMap(json.decode(str));
  // factory CreditsMovieReponse.fromRawJson(String str) => CreditsMovieReponse.fromJson(json.decode(str));

  // it's important to set the instance "fromMap" instead of "fromJson"
  factory CreditsMovieReponse.fromMap(Map<String, dynamic> json) => CreditsMovieReponse(
  // factory CreditsMovieReponse.fromJson(Map<String, dynamic> json) => CreditsMovieReponse(
    id: json["id"],
    // dont forget set fromMap instead of fromJson in case for the next lines
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
  );
}

class Cast {
  bool adult;
  int gender;
  int id;
  // Why I can't use own type with FutureBuilder check also line
  // KnownForDepartment knownForDepartment;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  get fullProfilePath {
    if ( profilePath != null ) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  // it's important to se the instance "fromJson" instead of "fromRawJson"   and "fromMap" instead of "fromJson"
  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  // it's important to set the instance "fromMap" instead of "fromJson"
  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    // Also why I cant' use a map
    // knownForDepartment: knownForDepartmentValues.map[json["known_for_department"]]!,
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"],
    job: json["job"],
  );
}


// the next code is used to implement my own type
enum KnownForDepartment {
  ACTING,
  CAMERA,
  DIRECTING,
  EDITING,
  PRODUCTION,
  SOUND
}

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Camera": KnownForDepartment.CAMERA,
  "Directing": KnownForDepartment.DIRECTING,
  "Editing": KnownForDepartment.EDITING,
  "Production": KnownForDepartment.PRODUCTION,
  "Sound": KnownForDepartment.SOUND
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
      reverseMap = map.map((k, v) => MapEntry(v, k));
      return reverseMap;
  }
}