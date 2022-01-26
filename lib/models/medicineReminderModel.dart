// ignore_for_file: file_names
final String tableMedicine = 'medicine';

class medicineField {
  static final List<String> values = [id, medicineName, genericName, brandName, medicineType, dose, unit, date, time, colour, status];
  static final String id = '_id';
  static final String medicineName = 'medicineName';
  static final String genericName = 'genericName';
  static final String brandName = 'brandName';
  static final String medicineType = 'medicineType';
  static final String unit = 'unit';
  static final String dose = 'dose';
  static final String date = 'date';
  static final String time = 'time';
   static final String colour = 'colour';
  static final String status = 'status';
}

class medicineReminderModel {
  final int? id;
  final String medicineName;
  final String genericName;
  final String brandName;
  final String medicineType;
  final String unit;
  final String dose;
  final String date;
  final String time;
  final String colour;
  final bool status;
  medicineReminderModel(
      {this.id,
      required this.medicineName,
      required this.genericName,
      required this.brandName,
      required this.medicineType,
      required this.unit,
      required this.dose,
      required this.date,
      required this.time,
      required this.colour,
      required this.status});

  medicineReminderModel copy({
    int? id,
    String? medicineName,
    String? genericName,
    String? brandName,
    String? medicineType,
    String? unit,
    String? dose,
    String? date,
    String? time,
    String? colour,
    bool? status,
  }) =>
      medicineReminderModel(
          id: id ?? this.id,
          medicineName: medicineName ?? this.medicineName,
          genericName: genericName ?? this.genericName,
          brandName: brandName ?? this.brandName,
          medicineType: medicineType ?? this.medicineType,
          unit: unit ?? this.unit,
          dose: dose ?? this.dose,
          date: date ?? this.date,
          time: time ?? this.time,
          colour: colour ?? this.colour,
          status: status ?? this.status
          );

  static medicineReminderModel fromJson(Map<String, Object?> json) =>
      medicineReminderModel(
          id: json[medicineField.id] as int,
          medicineName: json[medicineField.medicineName] as String,
          genericName: json[medicineField.genericName] as String,
          brandName: json[medicineField.brandName] as String,
          medicineType: json[medicineField.medicineType] as String,
          unit: json[medicineField.unit] as String,
          dose: json[medicineField.dose] as String,
          date: json[medicineField.date] as String,
          time: json[medicineField.time] as String,
          colour: json[medicineField.colour] as String,
          status: json[medicineField.status] == 1
          
          );
  Map<String, Object?> toJson() => {
        medicineField.id: id,
        medicineField.medicineName: medicineName,
        medicineField.genericName: genericName,
        medicineField.brandName: brandName,
        medicineField.medicineType: medicineType,
        medicineField.unit: unit,
        medicineField.dose: dose,
        medicineField.date: date,
        medicineField.time: time,
        medicineField.colour: colour,
        medicineField.status: status ? 1:0,
      };
}
