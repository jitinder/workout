class WorkoutExercise {
  String name;
  String description;
  int sets;

  WorkoutExercise(this.name, this.description, this.sets);

  WorkoutExercise.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        sets = json['sets'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'sets': sets};
}

class WorkoutPlan {
  String name;
  List<WorkoutExercise> monday;
  List<WorkoutExercise> tuesday;
  List<WorkoutExercise> wednesday;
  List<WorkoutExercise> thursday;
  List<WorkoutExercise> friday;
  List<WorkoutExercise> saturday;
  List<WorkoutExercise> sunday;

  WorkoutPlan(this.name, this.monday, this.tuesday, this.wednesday,
      this.thursday, this.friday, this.saturday, this.sunday);

  WorkoutPlan.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        monday = json["monday"],
        tuesday = json["tuesday"],
        wednesday = json["wednesday"],
        thursday = json["thursday"],
        friday = json["friday"],
        saturday = json["saturday"],
        sunday = json["sunday"];

  Map<String, dynamic> toJson() => {
        'name': name,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "sunday": sunday
      };
}
