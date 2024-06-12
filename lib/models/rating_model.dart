import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel{
  String id;
  String productId;
  String userId;
  String ten;
  String noiDung;
  Timestamp ngay;
  double soSao;

  DocumentReference reference;

  RatingModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );

  RatingModel.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['productId'] != null),
        assert(map['userId'] != null),
        assert(map['ten'] != null),
        assert(map['ngay'] != null),
        assert(map['soSao'] != null),
        assert(map['noiDung'] != null),

        id = map['id'],
        productId = map['productId'],
        userId = map['userId'],
        ten = map['ten'],
        ngay = map['ngay'],
        noiDung = map['noiDung'],
        soSao = double.parse(map['soSao'].toString());

  RatingModel({required this.id, required this.productId, required this.userId, required this.ten, required this.ngay, required this.soSao, required this.noiDung, required this.reference});

  @override
  String toString() => "Record<$id:$ten:$userId:$productId:$ngay:$soSao:$noiDung>";
}