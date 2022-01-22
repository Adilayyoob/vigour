// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vigour/models/documentUploadAreaModel.dart';

// class PreferenceService{
//   Future saveDocument(DocumentUploadAreaModel model) async {
//     final preferances = await SharedPreferences.getInstance();

//     await  preferances.setInt("id", model.id);
//     await  preferances.setString("title", model.title);
//     await  preferances.setString("date", model.date);
//     await  preferances.setString("imageURL", model.imageURL);
//     print("Document Saved!");
//   }

//   Future<DocumentUploadAreaModel> getDocument() async{
//     final preferances = await SharedPreferences.getInstance();
    
//     final id =  preferances.getInt("id");
//     final title =  preferances.getString("title");
//     final date =  preferances.getString("date");
//     final imageURL =  preferances.getString("imageURL");
//     return DocumentUploadAreaModel(id: id!,title: title!, date: date!, imageURL: imageURL!);
//   }
// }