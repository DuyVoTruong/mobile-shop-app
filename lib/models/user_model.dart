import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String id;
  String email;
  String password;
  String ten;
  String sdt;
  String diaChi;
  bool isUser;

  DocumentReference reference;

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );

  UserModel.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['email'] != null),
        assert(map['password'] != null),
        assert(map['ten'] != null),
        assert(map['sdt'] != null),
        assert(map['diaChi'] != null),
        assert(map['isUser'] != null),

        id = map['id'],
        email = map['email'],
        password = map['password'],
        ten = map['ten'],
        sdt = map['sdt'],
        diaChi = map['diaChi'],
        isUser = map['isUser'];

  UserModel({required this.id, required this.email, required this.password, required this.ten, required this.sdt, required this.diaChi, required this.isUser, required this.reference});

  @override
  String toString() => "Record<$id:$ten:$sdt:$diaChi:$email:$password:$isUser>";
}