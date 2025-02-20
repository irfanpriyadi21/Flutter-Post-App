import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pos_app/core/constants/variables.dart';
import 'package:mobile_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:mobile_pos_app/data/models/response/auth_response_model.dart';

class AuthRemoteDatasource {


  Future<Either<String, AuthResponseModel>> login(String email, String password)async{
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/login"),
      body: {
        'email' : email,
        'password' : password
      }
    );
     final responseData = json.decode(response.body);
    if(responseData['code'] == 200){
      return right(AuthResponseModel.fromRawJson(response.body));
    }else{
      return left(response.body);
    }

  }

  Future<Either<String, String>> logout()async{
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/logout"),
      headers: {
        "Authorization" : "Bearer ${authData.token}"
      }
    );
    if(response.statusCode == 200){
      return right(response.body);
    }else{
      return left(response.body);
    }

  }
  
}