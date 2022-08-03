class WorkoutExercise {
  String name;
  String description;
  int sets;
  int restTime;

  WorkoutExercise(this.name, this.description, this.sets, this.restTime);

  WorkoutExercise.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        sets = json['sets'],
        restTime = json['restTime'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'sets': sets,
        'restTime': restTime
      };
}

class WorkoutDay {
  String name;
  List<WorkoutExercise> exercises;

  WorkoutDay(this.name, this.exercises);

  WorkoutDay.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        exercises = List<WorkoutExercise>.from((json['exercises'] as List)
            .map((element) => WorkoutExercise.fromJson(element)));

  Map<String, dynamic> toJson() => {
        'name': name,
        "exercises": exercises,
      };
}

class WorkoutPlan {
  String name;
  WorkoutDay monday;
  WorkoutDay tuesday;
  WorkoutDay wednesday;
  WorkoutDay thursday;
  WorkoutDay friday;
  WorkoutDay saturday;
  WorkoutDay sunday;

  WorkoutPlan(this.name, this.monday, this.tuesday, this.wednesday,
      this.thursday, this.friday, this.saturday, this.sunday);

  WorkoutPlan.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        monday = WorkoutDay.fromJson(json["monday"]),
        tuesday = WorkoutDay.fromJson(json["tuesday"]),
        wednesday = WorkoutDay.fromJson(json["wednesday"]),
        thursday = WorkoutDay.fromJson(json["thursday"]),
        friday = WorkoutDay.fromJson(json["friday"]),
        saturday = WorkoutDay.fromJson(json["saturday"]),
        sunday = WorkoutDay.fromJson(json["sunday"]);

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
