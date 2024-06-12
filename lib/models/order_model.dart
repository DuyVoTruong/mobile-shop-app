import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class OrderModel{
  final String id;
  final List<dynamic> productList;
  final List<dynamic> soLuongList;
  final String userId;
  final DateTime ngayDat;
  final String tongTien;
  final String diaChiGiao;
  final int trangThai;
  final String hinhThucThanhToan;

  final DocumentReference reference;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );
  OrderModel.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['productList'] != null),
        assert(map['soLuongList'] != null),
        assert(map['userId'] != null),
        assert(map['ngayDat'] != null),
        assert(map['tongTien'] != null),
        assert(map['diaChiGiao'] != null),
        assert(map['trangThai'] != null),
        assert(map['hinhThucThanhToan'] != null),

        id = map['id'],
        productList = map['productList'].map((product)=>ProductModel.fromMap(product, reference: reference)).toList(),
        soLuongList = map['soLuongList'].map((soLuong)=>soLuong).toList(),
        userId = map['userId'],
        ngayDat = (map['ngayDat'] as Timestamp).toDate(),
        tongTien = map['tongTien'],
        diaChiGiao = map['diaChiGiao'],
        trangThai = map['trangThai'],
        hinhThucThanhToan = map['hinhThucThanhToan'];


  @override
  String toString() => "Record<$id:$productList:$soLuongList:$userId:$ngayDat:$tongTien:$diaChiGiao:$trangThai>";
}