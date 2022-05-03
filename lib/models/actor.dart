class Actor {
  Actor({
    required this.name,
    required this.birthYear,
    required this.hairColor,
  });

  String name;
  String birthYear;
  String hairColor;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        name: json["name"],
        birthYear: json["birth_year"],
        hairColor: json["hair_color"],
      );

  static List<Actor> fromList(List jsonlist) {
    List<Actor> actorsList = [];
    for (var item in jsonlist) {
      actorsList.add(Actor.fromJson(item));
    }
    return actorsList;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "hair_color": hairColor,
      };
}
