import 'package:meta/meta.dart';
import 'dart:convert';

class ProductResponseModel {
    final bool success;
    final String message;
    final List<Product> data;

    ProductResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductResponseModel.fromRawJson(String str) => ProductResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Product {
    final int id;
    final String name;
    final String description;
    final int price;
    final int stock;
    final String category;
    final String image;
    final String createdAt;
    final String updatedAt;

    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.stock,
        required this.category,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "",
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"] ?? "",
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "stock": stock ?? 0,
        "category": category,
        "image": image,
        "createdAt" : createdAt,
        "updatedAt" : updatedAt

    };
}


