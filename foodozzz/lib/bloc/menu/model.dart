class MenuModel {
  String? restaurantId;
  List<Menu>? menu;

  MenuModel({this.restaurantId, this.menu});

  MenuModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? itemId;
  String? name;
  int? price;
  String? category;

  Menu({this.itemId, this.name, this.price, this.category});

  Menu.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    return data;
  }
}
