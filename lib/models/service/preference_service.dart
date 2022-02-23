import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigour/models/drinkWaterReminderModel.dart';


class PreferenceService{
  Future saveWater(DrinkWaterReminderModel model) async {
    final preferances = await SharedPreferences.getInstance();

    await  preferances.setString("weight", model.weight);
    await  preferances.setBool("switchStatus", model.switchStatus);
    await  preferances.setString("cups", model.cups);
    print("Document Saved!");
  }

  Future<DrinkWaterReminderModel> getWater() async{
    final preferances = await SharedPreferences.getInstance();
    
    final weight =  preferances.getString("weight") ?? "Enter Your Weight (Kg)";
    final switchStatus =  preferances.getBool("switchStatus") ?? false;
    final cups =  preferances.getString("cups") ?? "";
    return DrinkWaterReminderModel(weight: weight, switchStatus: switchStatus, cups: cups);
    
  }
}