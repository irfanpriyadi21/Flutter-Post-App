import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_pos_app/data/datasources/product_remote_datasource.dart';
import 'package:mobile_pos_app/data/models/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  List<Product> product = [];
  ProductBloc(
    this._productRemoteDatasource
  ) : super(_Initial()) {
    
    on<_Fetch>((event, emit)async{
      emit(const ProductState.loading());
      final response = await _productRemoteDatasource.getProduct();
      response.fold(
        (l) => emit(ProductState.error(l)), 
        (r) {
          product = r.data;
          emit(ProductState.success(r.data));
        }
      );
    });

    on<_FetchByCategory>((event, emit)async{
      emit(const ProductState.loading());
      final newProduct = event.category == "all"
      ? product
      : product.where((element) => element.category == event.category)
      .toList();

      emit(ProductState.success(newProduct));
    });
  }
}
