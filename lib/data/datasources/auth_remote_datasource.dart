import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pos_app/core/constants/variables.dart';
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
    if(response.statusCode == 200){
      return right(AuthResponseModel.fromRawJson(response.body));
    }else{
      return left(response.body);
    }

  }
}