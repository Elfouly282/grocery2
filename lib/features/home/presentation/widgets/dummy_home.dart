
import '../../data/model/deals_model.dart';

class DummyDeals {
  static List<DealModel> deals = List.generate(
    1,
        (index) => DealModel(
      id: index,
      title: 'Loading Deal',
      description: '',
      imageUrl: 'https://via.placeholder.com/300x200.png?text=Loading',
      price: 0,
      finalPrice: 0,
      hasOffer: true,
      offerTitle: 'Offer',
    ),
  );
}