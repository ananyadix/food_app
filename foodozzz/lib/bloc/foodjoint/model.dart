class FJModel {
  String? id;
  String? name;
  String? category;
  double? rating;
  String? image;

  FJModel({this.id, this.name, this.category, this.rating, this.image});

  FJModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    rating = json['rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['rating'] = this.rating;
    data['image'] = this.image;
    return data;
  }
}
