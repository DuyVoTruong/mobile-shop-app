import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String id;
  final String username;
  final String password;
  final String ten;
  final String sdt;
  final String diaChi;
  final bool isUser;

  final DocumentReference reference;

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
        assert(map['username'] != null),
        assert(map['password'] != null),
        assert(map['ten'] != null),
        assert(map['sdt'] != null),
        assert(map['diaChi'] != null),
        assert(map['isUser'] != null),

        id = map['id'],
        username = map['username'],
        password = map['password'],
        ten = map['ten'],
        sdt = map['sdt'],
        diaChi = map['diaChi'],
        isUser = map['isUser'];

  @override
  String toString() => "Record<$id:$ten:$sdt:$diaChi:$username:$password:$isUser>";
}