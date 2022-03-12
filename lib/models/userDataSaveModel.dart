// model for login details
// ignore_for_file: file_names

class UserDataSaveModel {
  String UserName = "";
  String UserPassword = "";
  bool firstBoot = true;
  UserDataSaveModel(
      {required this.UserName,
      required this.UserPassword,
      required this.firstBoot});
}
