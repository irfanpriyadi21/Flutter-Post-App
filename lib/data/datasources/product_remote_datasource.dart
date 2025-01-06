
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mobile_pos_app/core/constants/variables.dart';
import 'package:mobile_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:mobile_pos_app/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;


class ProductRemoteDatasource {

  Future<Either<String, ProductResponseModel>> getProduct()async{
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/api/products"),
       headers: {
        "Authorization" : "Bearer ${authData.token}"
      }
    );
    if(response.statusCode == 200){

      return right(ProductResponseModel.fromRawJson(response.body));
    }else{
      return left(response.body);
    }
    
  }
}