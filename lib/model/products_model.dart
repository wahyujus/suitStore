import 'package:hive/hive.dart';
import 'package:suitcore_flutter_getx_base_code/data/local/hive/hive_types.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/model_factory.dart';

part 'products_model.g.dart';

@HiveType(typeId: HiveTypes.products)
class ProductsModel extends HiveObject implements ModelFactory {
  ProductsModel({
    required this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.count,
    // this.rating,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? image;
  @HiveField(6)
  int? count;
  // @HiveField(6)
  // Rating? rating;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        count: json["count"],
        // rating: json["rating"],
      );
}

// class Rating extends HiveObject implements ModelFactory {
//   Rating({
//     this.rate,
//     this.count,
//   });

//   double? rate;
//   dynamic count;

//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         rate: json["rate"],
//         count: json["count"],
//       );
// }
