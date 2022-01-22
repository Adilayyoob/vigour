// ignore_for_file: file_names
final String tableDocument = 'document';

class documentField {
  static final List<String> values = [id, title, date, imgURL];
  static final String id = '_id';
  static final String title = 'title';
  static final String date = 'date';
  static final String imgURL = 'imgURL';
}

class DocumentUploadAreaModel {
  final int? id;
  final String title;
  final String date;
  final String imgURL;
  DocumentUploadAreaModel(
      {this.id,
      required this.title,
      required this.date,
      required this.imgURL});

  DocumentUploadAreaModel copy({
    int? id,
    String? title,
    String? date,
    String? imgURL,
  }) =>
      DocumentUploadAreaModel(
          id: id ?? this.id,
          title: title ?? this.title,
          date: date ?? this.date,
          imgURL: imgURL ?? this.imgURL);

  static DocumentUploadAreaModel fromJson(Map<String, Object?> json) =>
      DocumentUploadAreaModel(
          id: json[documentField.id] as int,
          title: json[documentField.title] as String,
          date: json[documentField.date] as String,
          imgURL: json[documentField.imgURL] as String);
  Map<String, Object?> toJson() => {
        documentField.id: id,
        documentField.title: title,
        documentField.date: date,
        documentField.imgURL: imgURL,
      };
}
