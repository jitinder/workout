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
        exercises = json["exercises"];

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
