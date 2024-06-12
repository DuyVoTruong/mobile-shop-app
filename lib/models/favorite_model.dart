import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class FavoriteModel{
  final String id;
  final String userId;
  final ProductModel product;

  final DocumentReference reference;

  FavoriteModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );
  FavoriteModel.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['product'] != null),
        assert(map['userId'] != null),
        id = map['id'],
        product = ProductModel.fromMap(map['product'], reference: reference),
        userId = map['userId'];

  @override
  String toString() => "Record<$product:$userId:$id>";
}