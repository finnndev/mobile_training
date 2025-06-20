
class Stylist {
  final String name;
  final String image;

  Stylist({required this.name, required this.image});

 
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
      };


  factory Stylist.fromJson(Map<String, dynamic> json) {
    return Stylist(
      name: json['name'],
      image: json['image'],
    );
  }
}