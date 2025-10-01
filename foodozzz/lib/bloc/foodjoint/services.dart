import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:foodozzz/bloc/foodjoint/model.dart';

class FJServices {
  Future<List<FJModel>> getRestaurants() async {
    final String response = await rootBundle.loadString('assests/data/foodjoint.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => FJModel.fromJson(json)).toList();
  }
}
