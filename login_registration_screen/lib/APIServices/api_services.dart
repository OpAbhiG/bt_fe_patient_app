import 'dart:convert';
import 'package:login_registration_screen/APIServices/base_api.dart';


import '../models/model.dart';
// import 'model.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  Future<LoginModel?> loginWithModel( String email, String password)async{

    try{
      var url = Uri.parse("$baseapi/user/login");
      var response = await http.post(url, body: {
        "email": email,
        "password": password
      });


      if(response.statusCode == 200 || response.statusCode==201){
        LoginModel model = LoginModel.fromJson(jsonDecode(response.body));
        return model;
      }
    }catch (e){
      print(e);
    }
    return null;
  }





  Future<void>RegistrationScreen(String email, String password, String fname,String lname ) async {
    try {
      var url = Uri.parse("$localurl/create_user");
      var response = await http.post(
        url,
        body: {"email": email, "password": password,"fname":fname,"lname":lname,"user_type":"1"},
      );

      if (response.statusCode != 200) {
        throw Exception('Sign up failed: ${response.body}');
      }
    } catch (e) {
      print('Error during sign up: $e');
      throw e;
    }
  }



  // Future<RegistrationModel?> registerUser({
  //   required String firstName,
  //   required String lastName,
  //   required String gender,
  //   required int age,
  //   required String aadhaarNumber,
  //   required String mobileNumber,
  //   required String email,
  //   required String password,
  // }) async {
  //   var url = Uri.parse("$baseapi/user/create_user");
  //
  //   try {
  //     var response = await http.post(
  //       url,
  //       body: {
  //         "first_name": firstName,
  //         "last_name": lastName,
  //         "gender": gender,
  //         "age": age.toString(),
  //         "aadhaar_number": aadhaarNumber,
  //         "mobile_number": mobileNumber,
  //         "email": email,
  //         "password": password,
  //       },
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return RegistrationModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       print("Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //   }
  //
  //   return null;
  // }

// Future<dynamic> loginWithOutModel( String email, String password)async{
//
//   try{
//     var url = Uri.parse("https://reqres.in/api/login");
//     var response = await http.post(url, body: {
//       "email": email,
//       "password": password
//     });
//
//
//     if(response.statusCode == 200){
//       final model = jsonDecode(response.body);
//       return model;
//     }
//   }catch (e){
//     print(e);
//   }
// }


}