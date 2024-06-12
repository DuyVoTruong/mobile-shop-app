import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  final String id;
  final String image;
  final int gia;
  final String moTa;
  final String ten;
  final String brand;
  final String color;
  final String ram;
  final String rom;
  final double size;
  final double soSao;
  final int soDanhGia;
  final int soLuongDaBan;

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
        assert(map['brand'] != null),
        assert(map['color'] != null),
        assert(map['ram'] != null),
        assert(map['rom'] != null),
        assert(map['size'] != null),
        assert(map['soSao'] != null),
        assert(map['soDanhGia'] != null),
        assert(map['soLuongDaBan'] != null),

        id = map['id'],
        ten = map['ten'],
        gia = map['gia'],
        moTa = map['moTa'],
        image = map['image'],
        brand = map['brand'],
        color = map['color'],
        ram = map['ram'],
        rom = map['rom'],
        size = double.parse(map['size'].toString()),
        soSao = double.parse(map['soSao'].toString()),
        soDanhGia = map['soDanhGia'],
        soLuongDaBan = map['soLuongDaBan'];


  @override
  String toString() => "Record<$id:$ten:$gia:$moTa:$image>";
}