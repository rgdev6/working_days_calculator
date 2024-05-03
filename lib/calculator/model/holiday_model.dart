class HolidayModel {
  String date;
  String name;
  String type;
  String level;

  // Constructor
  HolidayModel(
      {required this.date,
      required this.name,
      required this.type,
      required this.level});

  DateTime parseDate() => DateTime.parse(date);

  String formatDDMM() => "${date.substring(8,10)}/${date.substring(5,7)}";

  // Method to instantiate the model from JSON
  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json["date"] as String,
      name: json["name"] as String,
      type: json["type"] as String,
      level: json["level"] as String,
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "name": name,
      "type": type,
      "level": level,
    };
  }
}
