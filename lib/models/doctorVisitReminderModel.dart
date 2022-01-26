// ignore_for_file: file_names
final String tableDoctor = 'doctor';

class doctorField {
  static final List<String> values = [id, name, date, time, location, status];
  static final String id = '_id';
  static final String name = 'name';
  static final String date = 'date';
  static final String time = 'time';
  static final String location = 'location';
  static final String status = 'status';
}

class DoctorVisitReminderModel {
  final int? id;
  final String name;
  final String date;
  final String time;
  final String location;
  final bool status;
  DoctorVisitReminderModel(
      {this.id,
      required this.name,
      required this.date,
      required this.time,
      required this.location,
      required this.status});

  DoctorVisitReminderModel copy({
    int? id,
    String? name,
    String? date,
    String? time,
    String? location,
    bool? status,
  }) =>
      DoctorVisitReminderModel(
          id: id ?? this.id,
          name: name ?? this.name,
          date: date ?? this.date,
          time: time ?? this.time,
          location: location ?? this.location,
          status: status ?? this.status
          );

  static DoctorVisitReminderModel fromJson(Map<String, Object?> json) =>
      DoctorVisitReminderModel(
          id: json[doctorField.id] as int,
          name: json[doctorField.name] as String,
          date: json[doctorField.date] as String,
          time: json[doctorField.time] as String,
          location: json[doctorField.location] as String,
          status: json[doctorField.status] == 1
          
          );
  Map<String, Object?> toJson() => {
        doctorField.id: id,
        doctorField.name: name,
        doctorField.date: date,
        doctorField.time: time,
        doctorField.location: location,
        doctorField.status: status ? 1:0,
      };
}
