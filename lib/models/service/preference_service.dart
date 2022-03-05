import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigour/models/drinkWaterReminderModel.dart';
import 'package:vigour/models/userDataSaveModel.dart';

class PreferenceService {
  Future saveWater(DrinkWaterReminderModel model) async {
    final preferances = await SharedPreferences.getInstance();

    await preferances.setString("weight", model.weight);
    await preferances.setBool("switchStatus", model.switchStatus);
    await preferances.setString("cups", model.cups);
    await preferances.setString("days", model.days);
    print("Document Saved!");
  }

  Future<DrinkWaterReminderModel> getWater() async {
    final preferances = await SharedPreferences.getInstance();

    final weight = preferances.getString("weight") ?? "Enter Your Weight (Kg)";
    final switchStatus = preferances.getBool("switchStatus") ?? false;
    final cups = preferances.getString("cups") ?? "";
    final days = preferances.getString("days") ?? "Notification for how many Days?";
    return DrinkWaterReminderModel(
        weight: weight, switchStatus: switchStatus, cups: cups, days: days);
  }

  //user data save
  Future saveUser(UserDataSaveModel model) async {
    final preferances = await SharedPreferences.getInstance();

    await preferances.setString("UserName", model.UserName);
    await preferances.setString("UserPassword", model.UserPassword);
    print("Document Saved!");
  }

  Future<UserDataSaveModel> getUser() async {
    final preferances = await SharedPreferences.getInstance();

    final UserName = preferances.getString("UserName") ?? "";
    final UserPassword = preferances.getString("UserPassword") ?? "";
    return UserDataSaveModel(UserName: UserName, UserPassword: UserPassword);
  }
}
