import 'package:grocery2/features/Home/data/category_model.dart';

class DealModel {
  final int id;

  final String title;

  

  final String ?description;

  final String ?imageUrl;

  final String? offerTitle;



 
 

  DealModel({
    required this.id,

    required this.title,

   

    required this.description,

    required this.imageUrl,

    this.offerTitle,

    
  });

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
    id: json['id'],

    title: json['title'],

 
    description: json['description']??'this offer is best offers /n in this seazon',

    imageUrl: json['image_url'],

    offerTitle: json['offer_title']??' ',
 
  );

  /// Calculates discount percentage from price and finalPrice

   
}
