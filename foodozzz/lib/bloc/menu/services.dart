import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:foodozzz/bloc/menu/model.dart';

class MenuServices {
  Future<List<MenuModel>> getMenus() async {
    try {
      final String response = await rootBundle.loadString('assests/data/menu.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => MenuModel.fromJson(json)).toList();
    } catch (e) {
      print("Error loading menu.json: $e");
      return [];
    }
  }

  Future<MenuModel?> getMenuByRestaurantId(String restaurantId) async {
    final menus = await getMenus();
    try {
      return menus.firstWhere(
            (menu) => menu.restaurantId == restaurantId,
        orElse: () => MenuModel(restaurantId: restaurantId, menu: []),
      );
    } catch (e) {
      print("Error fetching menu for $restaurantId: $e");
      return null;
    }
  }
}
