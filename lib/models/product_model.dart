import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  final String id;
  final String image;
  final int gia;
  final String moTa;
  final String ten;

  final DocumentReference reference;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );
  ProductModel.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['ten'] != null),
        assert(map['moTa'] != null),
        assert(map['gia'] != null),
        assert(map['image'] != null),
        id = map['id'],
        ten = map['ten'],
        gia = map['gia'],
        moTa = map['moTa'],
        image = map['image'];


  @override
  String toString() => "Record<$id:$ten:$gia:$moTa:$image>";
}